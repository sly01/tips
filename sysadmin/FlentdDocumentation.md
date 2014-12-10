##Elasticsearch-Fluentd-Kibana Documentation

**1- installing to java for elasticsearch**

```
sudo apt-get update
sudo apt-get install openjdk-7-jre-headless --yes
```

*Then verify installed java, output should be as follows*
```
java version "1.7.0_55"
OpenJDK Runtime Environment (IcedTea 2.4.7) (7u55-2.4.7-1ubuntu1)
OpenJDK 64-Bit Server VM (build 24.51-b03, mixed mode)
```

**2- Next, download and install Elasticsearch's deb package as follows**
```
sudo wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.2.deb
sudo dpkg -i elasticsearch-1.2.2.deb
```

*For securing issue Elasticsearch*

**Edit /etc/elasticsearch/elasticsearch.yml add this line**
```
script.disable_dynamic: true
```
**3- Then, start elasticsearch**
```
sudo service elasticsearch start
```

**4- Installing and Configuring Kibana**

```
cd /opt
curl -L https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xzf -
sudo cp -r kibana-3.1.0 /usr/share/
```
*Change this line in /usr/share/kibana-3.1.0/config.js*
```
elasticsearch: "http://"+window.location.hostname+":80"
```
**5- Installing and Configuring Nginx**
```
sudo apt-get install nginx
```
*Configuration nginx as a proxy server to serve dashboard to public internet*
```
wget https://assets.digitalocean.com/articles/fluentd/nginx.conf
sudo cp nginx.conf /etc/nginx/sites-available/default
```

*Edit the nginx file which download from digitalocean as follow*

```
server {
  listen                *:80 ;
  server_name           kibana.myhost.com;
  access_log            /var/log/nginx/kibana_access.log;
  error_log             /var/log/nginx/kibana_error.log;
  location / {
    root  /usr/share/kibana-3.1.0;
    index  index.html  index.htm;
  }
```

*Then restart nginx*
```
sudo service nginx restart
```
**6- Installing and Configuration Fluentd**

*Installing Fluentd which is built and maintained by Treasure Data*

```
wget http://packages.treasuredata.com/2/ubuntu/trusty/pool/contrib/t/td-agent/td-agent_2.0.4-0_amd64.deb
sudo dpkg -i td-agent_2.0.4-0_amd64.deb
```

*Installing the plugins*

**We need a couple of plugins:**

  *1.out_elasticsearch: this plugin lets Fluentd to stream data to Elasticsearch.*
  *2.outrecordreformer: this plugin lets us process data into a more useful format.*
  *3.S3:                this plugin lets us store data in amazon-s3 servers.*

*For out_elasticsearch install make and curl as follows*

```
sudo apt-get install make libcurl4-gnutls-dev --yes
```

```
sudo /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-elasticsearch
sudo /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-record-reformer
sudo /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-s3
```

*Configuration of fluentd for syslog and nginx access log and store localhost and amazon-s3 add those line to /etc/td-agent/td-agent.conf on the top*

```
<source>
type syslog
port 5140
tag  system
</source>

<source>
type tail
format nginx
tag nginx.access
path /var/log/nginx/kibana.log
pos_file /var/log/td-agent/kibana.log.post
# Date and time format
time_format %d/%b/%Y:%H:%M:%S %z
</source>

<match **>
type copy
<store>
type elasticsearch
logstash_format true
host localhost
port 9200
</store>

<store>
type s3
aws_key_id ACCESS-KEY
aws_sec_key SECRET-KEY
s3_bucket BUCKET-NAME
s3_region REGION
#Path on the bucket
path logs/
#Before sending to logs where to store
buffer_path /var/log/td-agent/buffer/s3
time_slice_format %Y-%m-%d/%H
time_slice_wait 10m
</store>

</match>
```

**To check the syntax of td-agent conf**

```
sudo service td-agent configtest
```

**Starting fluentd**

```
sudo service td-agent start
```

**Note that after editing the configuration file restart td-agent**

**7- Forwarding syslog to Fluentd**

*Add this line to /etc/rsyslog.conf*

```
Specified port in td-agent.conf for rsyslog -> Port
*.* @fluentdServerIp:Port
```

*Then restart rsyslog take effect*
```
sudo service rsyslog restart
```

#####Now when you got server ip you should see the dashboard.
