####Install the PPTD package

```
sudo apt-get install pptpd
```

####Configure VPN and DNS IP addresses

```
vi /etc/pptpd.conf
```
**Edit like this**

```
localip <yourserverlocalip>
remoteip <clientiprange>
```
*Example*

```
localip 10.0.0.5
remoteip 10.0.0.10-254
```

######Configure DNS server

```
vi /etc/ppp/pptpd-options
```

**Edit like this**

```
ms-dns 8.8.8.8
ms-dns 8.8.4.4
```
####Create a client account

```
vi /etc/ppp/chap-secrets
```

**Edit like this**

_Line format is username * passsword *_

```
test * 123456 *
```

**Restart the pptpd service**

```
service pptpd restart
```

####Enable forwarding

```
vi /etc/sysctl.conf
```

**Edit like this**

```
net.ipv4.ip_forward=1
```
**Make the changes take effect**

```
sysctl -p
```

#####Or

```
echo "1" > /proc/sys/net/ipv4/ip_forward
```

####Configure IPTABLES Rule

```
iptables -I INPUT -p tcp --dport 1723 -m state --state NEW -j ACCEPT
iptables -I INPUT -p gre -j ACCEPT
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
```

```
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -s <iprangeforremoteip> -j TCPMSS  --clamp-mss-to-pmtu
```

*Example*

```
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -s 10.0.20.10/24 -j TCPMSS  --clamp-mss-to-pmtu
```