### Installing HAProxy on Ubuntu

#### To install the HAProxy

```
sudo apt-get install haproxy
```

#### Then need to enable to start by init script.
**Edit ENABLED=1**

```
vi /etc/default/haproxy
```

#### To start the HAProxy

```
service haproxy start
```

### Let's assume you will Set Up HTTP Load Balancing

**Let's say there are 3 machines**

1. HAProxy Server (Hostname: loadbalancer Os:Ubuntu ip:10.0.47.4)
2. Nginx Application Server (Hostname: www1 Os: ubuntu ip: 10.0.47.5)
3. Nginx Application Server (Hostname: www2 Os: ubuntu ip: 10.0.47.6)

#### Configuring HAProxy

**Move default configuration like this**

```
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original
```

**Create a new configuration file**

```
vi /etc/haproxy/haproxy.cfg
```

**Edit like these**

```
global
    log 127.0.0.1 local0 notice
    maxconn 2000
    user haproxy
    group haproxy

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    retries 3
    option redispatch
    timeout connect  5000
    timeout client  10000
    timeout server  10000

listen appname 0.0.0.0:80
    mode http
    stats enable
    stats uri /haproxy?stats
    stats realm Strictly\ Private
    stats auth test:1234
    balance roundrobin
    option httpclose
    option forwardfor
    server www1 10.0.47.5:80 check
    server www2 10.0.47.6:80 check
```

###Testing Part

**Create a file named file.php both application server www1 and www2. By the way install apache2 or nginx and php for testing http load balancer.**

```
vi /var/www/file.php
```

**Edit like these**

```
<?php
header('Content-Type: text/plain');
echo "Server IP: ".$_SERVER['SERVER_ADDR'];
echo "\nClient IP: ".$_SERVER['REMOTE_ADDR'];
echo "\nX-Forwarded-for: ".$_SERVER['HTTP_X_FORWARDED_FOR'];
?>
```

**Then make some request from loadbalancer for file.php**

```
curl http://10.0.47.4/file.php
```

**Then output will be like this**

```
Server IP: 10.0.47.5
Client IP: 10.0.47.4
X-Forwarded-for: 192.168.1.22
Server IP: 10.0.47.6
Client IP: 10.0.47.4
X-Forwarded-for: 192.168.1.22
Server IP: 10.0.47.5
Client IP: 10.0.47.4
X-Forwarded-for: 192.168.1.22
Server IP: 10.0.47.6
Client IP: 10.0.47.4
X-Forwarded-for: 192.168.1.22
....
....
....
So on
```

#### The stats directives enable the connection statistics page and protects it with HTTP Basic authentication using the credentials specified by the stats auth directive in haproxy.conf. Take a look http://10.0.47.4/haproxy?stats.
