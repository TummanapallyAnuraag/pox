#!/bin/bash
sudo ovs-ofctl dump-flows sw0 > data/flowdump
echo "dst_ip - prefix - mac_src - mac_dst - out_of_port"
grep -o 'nw_dst.*' data/flowdump | sed 's/\//\ /g' | sed 's/nw_dst=//g' | sed 's/actions=//g' | sed 's/mod_dl_src://g' | sed 's/,mod_dl_dst:/\ /g' | sed 's/,output:/\ /g' | sed 's/\ /,/g' | tee data/routes.csv

./info.sh | grep -o "name.*" | cut -d':' -f2 | sed 's/"//g' | sed 's/\ //g' > data/if_name
./info.sh | grep -o "ofport.*" | cut -d':' -f2 | sed 's/"//g' | sed 's/\ //g' > data/of_ports
./info.sh | grep -o "mac_in_use.*" | cut -d'"' -f2 | sed 's/"//g' | sed 's/\ //g' > data/if_mac
./info.sh | grep -o "ifindex.*" | cut -d':' -f2 | sed 's/"//g' | sed 's/\ //g' > data/if_index

echo ""

echo "of_port - if_index - if_name - if_mac"
paste -d',' data/of_ports data/if_index data/if_name data/if_mac | tee data/iface_info.csv
