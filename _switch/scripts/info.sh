#!/bin/bash

# List of all ports, ifindexes, and ofport numbers, with MAC addresses
sudo ovs-vsctl -- --columns=name,ofport,mac_in_use,ifindex list Interface
