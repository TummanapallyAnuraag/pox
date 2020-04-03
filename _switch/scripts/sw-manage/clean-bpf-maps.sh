#!/bin/bash

echo "WARNING: deleting all BPF maps (make sure no bpf prog requires these maps)"
sudo rm -rf /sys/fs/bpf/ovs-router
