1-apt-get install bind9 -> which is dns server, bind -> berkeley internet domain name

2-Create db.test.com in /etc/bind/ 
cd /etc/bind
cp db.empty db.test.com

3-edit db.test.com

;
; BIND data file for local loopback interface
;
$TTL 3D
@       IN      SOA     deb6.test.com. root.test.com. (
                       1               ; serial
                       60480           ; refresh, seconds
                       86400           ; retry, seconds
                       2419200            ; expire, seconds
                       86400 )          ; minimum, seconds
;
                NS      deb6;           
   		A       192.168.2.11;
		MX      10	mail;
		MX	100	mail2;
deb6	A	192.168.2.11
www	A	192.168.2.11
www2	CNAME	www

4-edit /etc/bind/named.conf

zone "test.com"{
	type master;
	file "/etc/bind/db.test.com";
};

5-Check named.conf is Ok ?

named-checkconf named.conf

6-Edit your nameserver
/etc/resolv.conf
nameserver 127.0.0.1 -> your bind server

7-Then start the bind9
/etc/init.d/bind9 start
/etc/init.d/bind9 reload 

Note: If you change anything in db.test.com you have to change serial,you have to add +1. That's why It is better to declare serial number
the exact date like 20130929

SOA=Start of authority
Zone=Domain name
TTL=Time to live
NS=Name server
MX=Mail exchanger
A=Adress mapping host-ip/ip-host
CNAME=Alias
rndc=Remote name domain contoll
Forwarders= /etc/bind/named.conf.options put forwarders like 8.8.8.8 google dns server.
It means that if your dns doesn't resolve the host name then it send the google dns server in this example
