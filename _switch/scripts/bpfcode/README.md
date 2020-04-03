# Description

This folder contains all the scripts necessary to run BPF code on a switch.

## Usage
```
sudo mount -t bpf bpf /sys/fs/bpf ## Only once, after system startup.

## Starting/Attaching a BPF Code
sudo ./xdp_loader -d wlo1 -S ## For the first time, will create maps in /sys/fs/bpf/ovs-router/

sudo ./xdp_loader -d wlo1 -SM ## Don't create new maps, use existing ones.

sudo ./xdp_loader -d wlo1 -SM --force ## Create new maps.

## Removing a BPF code
sudo ./xdp_loader -d wlo1 -SU ## To remove the BPF code, but will retain the maps.
```

## Debugging
```
sudo cat /sys/kernel/debug/tracing/trace_pipe
```

## Handling BPF MAPS
```
sudo ./map_updater routes insert 192.168.0.1/32 3 ## Using map_updater C executable

## Using bpftool tool (for little endian system)
bpftool map lookup pinned /sys/fs/bpf/ovs-router/routes key 32 0 0 0 192 168 1 2
```

## BPF MAPS

Folder: `/sys/fs/bpf/ovs-router/`

| Map Name    | Type                     | Information                              |
| :---        |     :---                 |          :---                            |
| counter     | `BPF_MAP_TYPE_ARRAY`     | counts number of packets recieved        |
| tx_port     | `BPF_MAP_TYPE_DEVMAP`    | maps ofport no. to iface no.             |
| routes      | `BPF_MAP_TYPE_LPM_TRIE`  | ip/prefix to dst_mac/ofport out map      |
| sw_nics     | `BPF_MAP_TYPE_ARRAY`     | ifaceno. to iface mac addr information   |

Maps:

* `counter` - Counts no. of packets `BPF_MAP_TYPE_ARRAY`
> key - int
> val - int

```
sudo ./map_updater counter update 1 200
sudo ./map_updater counter delete 1
sudo ./map_updater counter lookup 1

sudo bpftool map update pinned /sys/fs/bpf/ovs-router/counter key 1 0 0 0 val 200
sudo bpftool map update pinned /sys/fs/bpf/ovs-router/counter key 1 0 0 0 val 0xc8

sudo bpftool map delete pinned /sys/fs/bpf/ovs-router/counter key 1 0 0 0

sudo bpftool map lookup pinned /sys/fs/bpf/ovs-router/counter key 1 0 0 0
```

* `tx_port` - To redirect packets to other NICs `BPF_MAP_TYPE_DEVMAP`
> key - int
> val - int

```
sudo ./map_updater tx_port update 1 1
sudo ./map_updater tx_port delete 1
sudo ./map_updater tx_port lookup 1

sudo bpftool map update pinned /sys/fs/bpf/ovs-router/tx_port key 1 0 0 0 val 1 0 0 0
sudo bpftool map update pinned /sys/fs/bpf/ovs-router/tx_port key 1 0 0 0 val 0x01

sudo bpftool map delete pinned /sys/fs/bpf/ovs-router/tx_port key 1 0 0 0

sudo bpftool map lookup pinned /sys/fs/bpf/ovs-router/tx_port key 1 0 0 0
```

* `routes` - For Routing Information Lookup `BPF_MAP_TYPE_LPM_TRIE`
> key -
```
union {
    __u32 b32[2];
    __u8 b8[8];
};
```
> val -
```
struct lpm_val {
	__u8 dst_mac[6];
	__u8 out_of_port;	// output openflow port
};
```

```
sudo ./map_updater routes update 192.168.0.1/16 01:02:03:ab:cd:ef/3
sudo ./map_updater routes delete 192.168.0.1/16
sudo ./map_updater routes lookup 192.168.0.1/16

sudo bpftool map update pinned /sys/fs/bpf/ovs-router/routes key 16 0 0 0 192 168 0 1 val 1 2 3 0xab 0xcd 0xef 3

sudo bpftool map delete pinned /sys/fs/bpf/ovs-router/routes key 16 0 0 0 192 168 0 1

sudo bpftool map lookup pinned /sys/fs/bpf/ovs-router/routes key 16 0 0 0 192 168 0 1
```

* `sw_nics` - For interface number to Device MAC Address translation `BPF_MAP_TYPE_ARRAY`
> key - int
> val - `__u8[6]`

```
sudo ./map_updater sw_nics update 3 01:02:03:a1:b2:c3
sudo ./map_updater sw_nics delete 3
sudo ./map_updater sw_nics lookup 3

sudo bpftool map update pinned /sys/fs/bpf/ovs-router/sw_nics key 3 0 0 0 val 0x01 0x02 0x03 0xa1 0xb2 0xc3

sudo bpftool map delete pinned /sys/fs/bpf/ovs-router/sw_nics key 3 0 0 0

sudo bpftool map lookup pinned /sys/fs/bpf/ovs-router/sw_nics key 3 0 0 0
```

## Compilation

Check the `Makefile` for more details

```
make
```
