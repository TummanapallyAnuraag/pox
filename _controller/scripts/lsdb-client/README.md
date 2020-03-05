# LSDB CLIENT

* `client.c`

Listens for Info about neighbours from each switch and populates in `data/<SW-IP-Addr>.txt` file, and exits

## COMPILATION

```
gcc -o client client.c
```

## USAGE

```
./client 192.168.3.250 [12345]
```

> IP Address of Target Switch is Mandatory, while PORT number is optional (Defaults to 12345)
