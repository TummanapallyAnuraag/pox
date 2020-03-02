## DESCRIPTION

* `info.sh`

> List of all ports, ifindexes, and ofport numbers, with MAC addresses


* `parse-flows.sh`

> Parses the Flow Entries in the switch and displays a sample of it [`../data/routes.csv` is the related file]


* `start-switch.sh`

> Needs modification specific to each switch like NIC details, IP Address of the switch, etc..

```
./_switch/scripts/start-switch.sh
53eaff41-1a3c-4ca7-837c-1f7c66d19dcd
    Bridge "sw0"
        Controller "tcp:192.168.2.250:6633"
        fail_mode: standalone
        Port "enp2s1"
            Interface "enp2s1"
        Port "enp2s0"
            Interface "enp2s0"
        Port "sw0"
            Interface "sw0"
                type: internal
    ovs_version: "2.9.5"
```

* `stop-switch.sh`

> To stop a switch
