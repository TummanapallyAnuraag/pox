# DIJKSTRA's ALGO



## COMPILATION

```
g++ -o dijkstra dijkstra.cpp
```

## USAGE

```
./dijkstra [-d]

python node-plot.py
```

> [-d] flag is optional for debug output

> `node-plot.py` generates `topo.png` topology picture

## PYTHON DEPENDENCIES

* `networkx`, `os`, `matplotlib`

```
pip install networkx matplotlib
```

> `os` is installed by default

## MISC.

`routes` folder contains `<SW-IP-Addr>.txt` files,

each file contains `<dst-ip, next-node-ip>` details after running Dijkstra's Algorithm

`../lsdb-client/data/<SW-IP-Addr>.txt` files are read for neighbour information by the `dijkstra.cpp` program
