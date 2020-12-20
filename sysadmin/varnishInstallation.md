### To fetch the gpg key

```
curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
```

### To add the repository list to source list

```
echo "deb http://repo.varnish-cache.org/debian/ wheezy varnish-3.0" >> /etc/apt/sources.list
```

### Fetch the Varnish Package

```
sudo apt-get update
```

### To install the Varnish

```
sudo apt-get install varnish
```

## Configuration of Varnish and Nginx

#### Run the Varnish on 80 port

```
vi /etc/default/varnish
```

##### Edit this line like this <port 80>

```
DAEMON_OPTS="-a :80 \
             -T localhost:6082 \
             -f /etc/varnish/default.vcl \
             -S /etc/varnish/secret \
             -s malloc,256m"
```

##### To tell Varnish where to look for the webserver content

```
vi /etc/varnish/default.vcl
```

**Edit Like This**

```
backend default {
    .host = "127.0.0.1";
    .port = "8080";
}
```

##### Configure Nginx to work and listen on port 8080

```
vi /etc/nginx/sites-available/domain.com
```

**Edit Like This**

```
listen  127.0.0.1:8080;
```

##### Delete default Virtual Hosts file of Nginx

```
rm /etc/nginx/sites-enabled/default
```

##### Now test Nginx config

```
nginx -t
```

##### Restart the Nginx

```
service nginx restart
```

##### Now restart Varnish as well

```
service varnish restart
```

##### To test the system work correctly

```
curl -I domain.com
```

**Then you will see that something like that**

```
X-Varnish: 1213869624
Age: 0
Via: 1.1 varnish
```

##### To see the varnishstat

```
varnishstat
```
