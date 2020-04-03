#!/bin/bash

sudo ovs-vsctl add-br sw0

if [ $# -eq 0 ] 
then
	# replace enp2s0 and enp2s1 with your network interface names (eg: eno1, eth0, wlo1, etc..)
	sudo ovs-vsctl add-port sw0 enp2s0
	sudo ovs-vsctl add-port sw0 enp2s1
else
	for iface in $*; do
	    sudo ovs-vsctl add-port sw0 $iface
	done
fi


sudo ovs-vsctl set-fail-mode sw0 standalone
sudo ovs-vsctl set-controller sw0 tcp:192.168.2.250:6633
sudo ovs-vsctl set controller sw0 connection-mode=out-of-band



sudo ovs-vsctl show
