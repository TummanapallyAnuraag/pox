#!/bin/bash

cat data/iface_info.csv | while read line
do
    echo $line
    of_port="$(echo $line | cut -d',' -f1)"
    ifindex="$(echo $line | cut -d',' -f2)"
    sudo ../bpfcode/map_updater tx_port update $of_port $ifindex
    sudo ../bpfcode/map_updater tx_port lookup $of_port
done

cat data/routes.csv | while read line
do
    echo $line
    ip_prefix="$(echo $line | cut -d',' -f1-2 | sed 's/,/\//g')"
    mac_out="$(echo $line | cut -d',' -f4-5| sed 's/,/\//g')"
    sudo ../bpfcode/map_updater routes update $ip_prefix $mac_out
    sudo ../bpfcode/map_updater routes lookup $ip_prefix
done
