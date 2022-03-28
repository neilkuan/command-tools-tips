## iptables (Amazon Linux2)
Iptable list of rules for NAT.
> Container in bridge network mode can access the external network through NAT which configured by iptables.

```bash
iptables --list -t nat
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         
DOCKER     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
DOCKER     all  --  anywhere            !ip-127-0-0-0.ap-northeast-1.compute.internal/8  ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  ip-172-17-0-0.ap-northeast-1.compute.internal/16  anywhere            
MASQUERADE  tcp  --  ip-172-17-0-2.ap-northeast-1.compute.internal  ip-172-17-0-2.ap-northeast-1.compute.internal  tcp dpt:http

Chain DOCKER (2 references)
target     prot opt source               destination         
RETURN     all  --  anywhere             anywhere            
DNAT       tcp  --  anywhere             anywhere             tcp dpt:49153 to:172.17.0.2:80
```


## curl (use telnet)
```bash
SUCCESS - connected to port 443
$ curl -v telnet://9.23.7.7:443
* About to connect() to port 443
*   Trying 9.23.7.7... * connected
* Connected to 9.23.7.7 (9.23.7.7) port 443

FAILED - failed connection to port 443
$ curl -v telnet://9.23.7.7:443
* About to connect() to 9.23.7.7 port 443
*   Trying 9.23.7.7... * Connection refused
* Closing connection #0
curl: (7) couldn't connect
```

## curl get http_code, remote_ip
```bash
for url in a b c; do curl -sL -w \
"http_code: %{http_code} remote_ip: %{remote_ip}\n" \
https://$url.example.com:443 -o /dev/nul; done

```
