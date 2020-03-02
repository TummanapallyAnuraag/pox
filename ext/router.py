"""
MTP Router

For each switch:
1) Keep a table that maps IP addresses to MAC addresses and switch ports.
   Stock this table using information from ARP and IP packets.
2) When you see an ARP query, try to answer it using information in the table
   from step 1.  If the info in the table is old, just flood the query.
3) Flood all other ARPs.
4) When you see an IP packet, if you know the destination port (because it's
   in the table from step 1), install a flow for it.
[[ NEW ]]**
5) Neighbour Switch (from Dijkstra's algo o/p) is discovered using ARPing on ConnectionUP
6) When ARPing of Neigh. Sw is done, install specific flows in each switch
"""

from pox.core import core
import pox
log = core.getLogger()

from pox.lib.packet.ethernet import ethernet, ETHER_BROADCAST
from pox.lib.packet.ipv4 import ipv4
from pox.lib.packet.arp import arp
from pox.lib.addresses import IPAddr, EthAddr
from pox.lib.util import str_to_bool, dpid_to_str
from pox.lib.recoco import Timer

import pox.openflow.libopenflow_01 as of
import pox.lib.packet as pkt

from pox.lib.revent import *

import time
import csv
import numpy as np

# Timeout for flows
FLOW_IDLE_TIMEOUT = 20

# Timeout for sw-sw flows
SWSW_FLOW_IDLE_TIMEOUT = 10

# Timeout for ARP entries
ARP_TIMEOUT = 60 * 2

# Maximum number of packet to buffer on a switch for an unknown IP
MAX_BUFFERED_PER_IP = 5

# Maximum time to hang on to a buffer for an unknown IP in seconds
MAX_BUFFER_TIME = 5

# Dijkstra's algorithm output folder
DJKSTRA_FLDR = "_controller/_data/routes.csv"

class Entry (object):
    """
    Not strictly an ARP entry.
    We use the port to determine which port to forward traffic out of.
    We use the MAC to answer ARP replies.
    We use the timeout so that if an entry is older than ARP_TIMEOUT, we
    flood the ARP request rather than try to answer it ourselves.
    """
    def __init__ (self, port, mac):
        self.timeout = time.time() + ARP_TIMEOUT
        self.port = port
        self.mac = mac

    def __eq__ (self, other):
        if type(other) == tuple:
            return (self.port,self.mac)==other
        else:
            return (self.port,self.mac)==(other.port,other.mac)

    def __ne__ (self, other):
        return not self.__eq__(other)

    def isExpired (self):
        if self.port == of.OFPP_NONE: return False
        return time.time() > self.timeout


def dpid_to_mac (dpid):
    return EthAddr("%012x" % (dpid & 0xffFFffFFffFF,))


class selfitch (EventMixin):
    def __init__ (self, fakeways = [], arp_for_unknowns = False, wide = False):
        # These are "fake gateways" -- we'll answer ARPs for them with MAC
        # of the switch they're connected to.
        self.fakeways = set(fakeways)

        # If True, we create "wide" matches.  Otherwise, we create "narrow"
        # (exact) matches.
        self.wide = wide

        # If this is true and we see a packet for an unknown
        # host, we'll ARP for it.
        self.arp_for_unknowns = arp_for_unknowns

        # (dpid,IP) -> expire_time
        # We use this to keep from spamming ARPs
        self.outstanding_arps = {}

        # (dpid,IP) -> [(expire_time,buffer_id,in_port), ...]
        # These are buffers we've gotten at this datapath for this IP which
        # we can't deliver because we don't know where they go.
        self.lost_buffers = {}

        # For each switch, we map IP addresses to Entries
        self.arpTable = {}

        # This timer handles expiring stuff
        self._expire_timer = Timer(5, self._handle_expiration, recurring=True)

        # Immediate neighbouring switches (IP address)
        self.nhop_switches = {}
        self.nhop_switch_cnt = {}
        self.nhop_switch_flow_installed = {}
        self.arp_for_nhop_sws_start_flag = {}
        self.sw_ip = {}
        self.sw_flow_install_time = {}

        core.listen_to_dependencies(self)

    def _handle_expiration (self):
        # Called by a timer so that we can remove old items.
        empty = []
        for k,v in self.lost_buffers.iteritems():
            dpid,ip = k
            for item in list(v):
                expires_at,buffer_id,in_port = item
                if expires_at < time.time():
                    # This packet is old.  Tell this switch to drop it.
                    v.remove(item)
                    po = of.ofp_packet_out(buffer_id = buffer_id, in_port = in_port)
                    core.openflow.sendToDPID(dpid, po)
            if len(v) == 0: empty.append(k)

        # Remove empty buffer bins
        for k in empty:
            del self.lost_buffers[k]

    def _send_lost_buffers (self, dpid, ipaddr, macaddr, port):
        """
        We may have "lost" buffers -- packets we got but didn't know
        where to send at the time.  We may know now.  Try and see.
        """
        if (dpid,ipaddr) in self.lost_buffers:
            # Yup!
            bucket = self.lost_buffers[(dpid,ipaddr)]
            del self.lost_buffers[(dpid,ipaddr)]
            log.debug("Sending %i buffered packets to %s from %s" % (len(bucket),ipaddr,dpid_to_str(dpid)))
            for _,buffer_id,in_port in bucket:
                po = of.ofp_packet_out(buffer_id=buffer_id,in_port=in_port)
                po.actions.append(of.ofp_action_dl_addr.set_dst(macaddr))
                po.actions.append(of.ofp_action_output(port = port))
                core.openflow.sendToDPID(dpid, po)

    def _handle_openflow_PacketIn (self, event):
        log.debug("I got a Packet In !!!!")
        dpid = event.connection.dpid
        inport = event.port
        packet = event.parsed
        if not packet.parsed:
            log.warning("%i %i ignoring unparsed packet", dpid, inport)
            return

        if dpid not in self.arpTable:
            # New switch -- create an empty table
            self.arpTable[dpid] = {}
            for fake in self.fakeways:
                self.arpTable[dpid][IPAddr(fake)] = Entry(of.OFPP_NONE, dpid_to_mac(dpid))

        if packet.type == ethernet.LLDP_TYPE:
          # Ignore LLDP packets
          return

        if isinstance(packet.next, ipv4):
            log.debug("%i %i IP %s => %s", dpid,inport,
                    packet.next.srcip,packet.next.dstip)

            # Send any waiting packets...
            self._send_lost_buffers(dpid, packet.next.srcip, packet.src, inport)

            # Learn or update port/MAC info
            if packet.next.srcip in self.arpTable[dpid]:
                if self.arpTable[dpid][packet.next.srcip] != (inport, packet.src):
                    log.info("%i %i RE-learned %s", dpid,inport,packet.next.srcip)
                    # Make sure we don't have any entries with the old info...
                    msg = of.ofp_flow_mod(command=of.OFPFC_DELETE)
                    msg.match.nw_dst = packet.next.srcip
                    msg.match.dl_type = ethernet.IP_TYPE
                    event.connection.send(msg)
            else:
                log.debug("%i %i learned %s", dpid,inport,packet.next.srcip)

            self.arpTable[dpid][packet.next.srcip] = Entry(inport, packet.src)
            self._try_installing_sw_sw_flows(event)

            # Try to forward
            dstaddr = packet.next.dstip
            if dstaddr in self.arpTable[dpid]:
                # We have info about what port to send it out on...

                prt = self.arpTable[dpid][dstaddr].port
                mac = self.arpTable[dpid][dstaddr].mac
                if prt == inport:
                    log.warning("%i %i not sending packet for %s back out of the "
                              "input port" % (dpid, inport, dstaddr))
                else:
                    log.debug("%i %i installing flow for %s => %s out port %i" % (dpid, inport, packet.next.srcip, dstaddr, prt))

                    actions = []
                    actions.append(of.ofp_action_dl_addr.set_dst(mac))
                    actions.append(of.ofp_action_output(port = prt))
                    match = of.ofp_match(dl_type = packet.type, nw_dst = dstaddr)

                    msg = of.ofp_flow_mod(command=of.OFPFC_ADD,
                                    idle_timeout=FLOW_IDLE_TIMEOUT,
                                    hard_timeout=of.OFP_FLOW_PERMANENT,
                                    buffer_id=event.ofp.buffer_id,
                                    actions=actions,
                                    match=match)
                    event.connection.send(msg.pack())
            elif self.arp_for_unknowns:
                # We don't know this destination.
                # First, we track this buffer so that we can try to resend it later
                # if we learn the destination, second we ARP for the destination,
                # which should ultimately result in it responding and us learning
                # where it is

                # Add to tracked buffers
                if (dpid,dstaddr) not in self.lost_buffers:
                    self.lost_buffers[(dpid,dstaddr)] = []
                bucket = self.lost_buffers[(dpid,dstaddr)]
                entry = (time.time() + MAX_BUFFER_TIME,event.ofp.buffer_id,inport)
                bucket.append(entry)
                while len(bucket) > MAX_BUFFERED_PER_IP: del bucket[0]

                # Expire things from our outstanding ARP list...
                self.outstanding_arps = {k:v for k,v in
                    self.outstanding_arps.iteritems() if v > time.time()}

                # Check if we've already ARPed recently
                if (dpid,dstaddr) in self.outstanding_arps:
                  # Oop, we've already done this one recently.
                  return

                # And ARP...
                self.outstanding_arps[(dpid,dstaddr)] = time.time() + 4

                r = arp()
                r.hwtype = r.HW_TYPE_ETHERNET
                r.prototype = r.PROTO_TYPE_IP
                r.hwlen = 6
                r.protolen = r.protolen
                r.opcode = r.REQUEST
                r.hwdst = ETHER_BROADCAST
                r.protodst = dstaddr
                r.hwsrc = packet.src
                r.protosrc = packet.next.srcip
                e = ethernet(type=ethernet.ARP_TYPE, src=packet.src, dst=ETHER_BROADCAST)
                e.set_payload(r)
                log.debug("%i %i ARPing for %s on behalf of %s" % (dpid, inport, r.protodst, r.protosrc))
                msg = of.ofp_packet_out()
                msg.data = e.pack()
                msg.actions.append(of.ofp_action_output(port = of.OFPP_FLOOD))
                msg.in_port = inport
                event.connection.send(msg)

        elif isinstance(packet.next, arp):
            a = packet.next
            log.debug("%i %i ARP %s %s => %s", dpid, inport,
            {arp.REQUEST:"request",arp.REPLY:"reply"}.get(a.opcode,
            'op:%i' % (a.opcode,)), a.protosrc, a.protodst)

            if (a.prototype == arp.PROTO_TYPE_IP) and (a.hwtype == arp.HW_TYPE_ETHERNET) and (a.protosrc != 0):
                # Learn or update port/MAC info
                if a.protosrc in self.arpTable[dpid]:
                    if self.arpTable[dpid][a.protosrc] != (inport, packet.src):
                        log.info("%i %i RE-learned %s", dpid,inport,a.protosrc)
                        # Make sure we don't have any entries with the old info...
                        msg = of.ofp_flow_mod(command=of.OFPFC_DELETE)
                        msg.match.dl_type = ethernet.IP_TYPE
                        msg.match.nw_dst = a.protosrc
                        event.connection.send(msg)

                else:
                    log.debug("%i %i learned %s", dpid,inport,a.protosrc)

                self.arpTable[dpid][a.protosrc] = Entry(inport, packet.src)
                self._try_installing_sw_sw_flows(event)

                # Send any waiting packets...
                self._send_lost_buffers(dpid, a.protosrc, packet.src, inport)

                if (a.opcode == arp.REQUEST) and (a.protodst in self.arpTable[dpid]):
                  # If it's a request, and we have an answer
                    if not self.arpTable[dpid][a.protodst].isExpired():
                        # .. and it's relatively current, so we'll reply ourselves
                        r = arp()
                        r.hwtype = a.hwtype
                        r.prototype = a.prototype
                        r.hwlen = a.hwlen
                        r.protolen = a.protolen
                        r.opcode = arp.REPLY
                        r.hwdst = a.hwsrc
                        r.protodst = a.protosrc
                        r.protosrc = a.protodst
                        r.hwsrc = self.arpTable[dpid][a.protodst].mac
                        e = ethernet(type=packet.type, src=dpid_to_mac(dpid), dst=a.hwsrc)
                        e.set_payload(r)
                        log.debug("%i %i answering ARP for %s" % (dpid, inport, r.protosrc))
                        msg = of.ofp_packet_out()
                        msg.data = e.pack()
                        msg.actions.append(of.ofp_action_output(port = of.OFPP_IN_PORT))
                        msg.in_port = inport
                        event.connection.send(msg)
                        return


            # Didn't know how to answer or otherwise handle this ARP, so just flood it
            log.debug("%i %i flooding ARP %s %s => %s" % (dpid, inport, {arp.REQUEST:"request",arp.REPLY:"reply"}.get(a.opcode, 'op:%i' % (a.opcode,)), a.protosrc, a.protodst))

            msg = of.ofp_packet_out(in_port = inport, data = event.ofp, action = of.ofp_action_output(port = of.OFPP_FLOOD))
            event.connection.send(msg)

    def _handle_openflow_ConnectionUp (self, event):
        # Pring Info about Switch
        self.sw_ip[event.dpid] = IPAddr(event.connection.sock.getpeername()[0]);
        self.nhop_switches[event.dpid] = {}
        self.nhop_switch_cnt[event.dpid] = 0
        self.nhop_switch_flow_installed[event.dpid] = 0
        self.arp_for_nhop_sws_start_flag[event.dpid] = 0
        self.sw_flow_install_time[event.dpid] = time.time()

        log.debug(" >> DPID: %s << ", event.dpid)
        log.debug(" >> MAC: %s << ", event.connection.eth_addr)
        log.debug(" >> SW IP: %s << ", self.sw_ip[event.dpid])
        port_count = len(event.ofp.ports)
        log.debug("# of Ports: %s", port_count)
        for port in event.ofp.ports:
            log.debug("%s", port)
        log.debug("")

        with open(DJKSTRA_FLDR, 'r') as file:
            data = csv.reader(file)
            next_hop_ips = np.array([]);
            for row in data:
                next_hop_ips = np.append( next_hop_ips, row[1])

        next_hop_ips = np.unique(next_hop_ips)
        for nhop_ip in next_hop_ips:
            if(nhop_ip !=  self.sw_ip[event.dpid]):
                self.nhop_switches[event.dpid][IPAddr(nhop_ip)] = IPAddr(nhop_ip)
                self.nhop_switch_cnt[event.dpid] = len(self.nhop_switches[event.dpid])


        self.arp_for_nhop_sws(event)

        return

    def arp_for_nhop_sws(self, event):
        for nhop_ip in self.nhop_switches[event.dpid]:
            r = arp()
            r.hwtype = r.HW_TYPE_ETHERNET
            r.prototype = r.PROTO_TYPE_IP
            r.hwlen = 6
            r.protolen = r.protolen
            r.opcode = r.REQUEST
            r.hwdst = ETHER_BROADCAST
            r.protodst = IPAddr(nhop_ip)
            r.hwsrc = EthAddr(event.connection.eth_addr)
            r.protosrc =  IPAddr(self.sw_ip[event.dpid])
            e = ethernet(type=ethernet.ARP_TYPE, src=r.hwsrc, dst=ETHER_BROADCAST)
            e.set_payload(r)
            log.debug("%i %i ARPing for %s on behalf of %s" % (event.dpid, of.OFPP_NONE, r.protodst, r.protosrc))
            msg = of.ofp_packet_out()
            msg.data = e.pack()
            msg.actions.append(of.ofp_action_output(port = of.OFPP_FLOOD))
            # msg.in_port = of.OFPP_FLOOD
            event.connection.send(msg)

        return

    def install_sw_sw_flows(self, event):
        for nhop in self.nhop_switches[event.dpid]:
            if(nhop ==  IPAddr(self.sw_ip[event.dpid])):
                continue
            log.debug("Installing Flow for %s", nhop)
            prt = self.arpTable[event.dpid][nhop].port
            mac = self.arpTable[event.dpid][nhop].mac
            actions = []
            actions.append(of.ofp_action_dl_addr.set_dst( EthAddr(mac) ) )
            actions.append(of.ofp_action_output(port = prt))
            match = of.ofp_match(dl_type = pkt.ethernet.IP_TYPE, nw_dst = (nhop, 24))
            msg = of.ofp_flow_mod(command=of.OFPFC_ADD,
                                  idle_timeout=SWSW_FLOW_IDLE_TIMEOUT,
                                  hard_timeout=of.OFP_FLOW_PERMANENT,
                                  # buffer_id=event.ofp.buffer_id,
                                  actions=actions,
                                  match=match)
            event.connection.send(msg.pack())

        self.nhop_switch_flow_installed[event.dpid] = 1
        self.sw_flow_install_time[event.dpid] = time.time()
        self.arp_for_nhop_sws_start_flag[event.dpid] = 0
        return

    def _try_installing_sw_sw_flows(self, event):
        dpid = event.dpid
        if(self.nhop_switch_flow_installed[dpid] == 0):
            # neighbouring SWITCHes are discovered?
            _mac_avlbl_flag = 1
            for nhop in self.nhop_switches[dpid]:
                if nhop not in self.arpTable[dpid]:
                    _mac_avlbl_flag = 0
                    break

            # If all neighbouring SWITCHes are discovered:
            if(_mac_avlbl_flag == 1):
                self.install_sw_sw_flows(event)
            else:
                log.debug("All neighb sw not discv yet :(")
        elif (time.time() - self.sw_flow_install_time[dpid] >= SWSW_FLOW_IDLE_TIMEOUT):
            # Already Installed, but expired, so
            # Install again..
            # neighbouring SWITCHes are discovered?
            _mac_avlbl_flag = 1
            for nhop in self.nhop_switches[dpid]:
                if nhop not in self.arpTable[dpid]:
                    _mac_avlbl_flag = 0
                    break

            # If all neighbouring SWITCHes are discovered:
            if(_mac_avlbl_flag == 1):
                self.install_sw_sw_flows(event)
            else:
                if(self.arp_for_nhop_sws_start_flag[dpid] == 0):
                    self.arp_for_nhop_sws_start_flag[dpid] = 1
                    self.arp_for_nhop_sws(event)
                else:
                    log.debug("%s All neighb sw not discv yet :(", dpid)
        return

def launch (fakeways="", arp_for_unknowns=None, wide=False):
    fakeways = fakeways.replace(","," ").split()
    fakeways = [IPAddr(x) for x in fakeways]
    if arp_for_unknowns is None:
        arp_for_unknowns = len(fakeways) > 0
    else:
        arp_for_unknowns = str_to_bool(arp_for_unknowns)
    core.registerNew(selfitch, fakeways, arp_for_unknowns, wide)
