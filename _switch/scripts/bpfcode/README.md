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

Maps:

* `counter` - Counts no. of packets `BPF_MAP_TYPE_ARRAY`

* `tx_port` - To redirect packets to other NICs `BPF_MAP_TYPE_DEVMAP`

* `routes` - For Routing Information Lookup `BPF_MAP_TYPE_LPM_TRIE`

## Compilation

Check the `Makefile` for more details

```
make
```
