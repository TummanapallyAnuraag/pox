# LSDB SERVER 

* `listen.c`

Listens for Incoming `OSPF HELLO` Packets and stores the data in `data/neighbours.txt` file every `30 seconds`

* `ospf.c`

Sends out OSPF Hello Packets with the given IP Address as source, so that other Switches can log it in their database

This is done every `10 seconds`

* `server.c`

Informs the `client.c` on Controller about the `neighbours.txt` so that controller can then perform Dijkstra's Algo on this data.


## COMPILATION

```
gcc -o listen liste.c -lrt

gcc -o ospf ospf.c -lrt

gcc-o server server.c
```

## USAGE

```
sudo ./listen eno1

sudo ./ospf eno1 192.168.2.250

./server [12345]
```

> Modify `eno1` to specific interface name for your SWITCH

> PORT Number is optional (Defaults to 12345) in ./server

# Neighbours Info

* `data/neighbours.txt` file has IP addresses of neighbouring routers.
