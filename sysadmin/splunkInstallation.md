##Splunk Installation

**1-First step downloading deb package from splunk web page**

**2-Asume you downloaded the file and name of it like this:**

```
splunk-6.2.1-245427-linux-2.6-amd64.deb

```

**3-To install it**

```
sudo dpkg -i splunk-6.2.1-245427-linux-2.6-amd64.deb

```

*All file will be in /opt/splunk*

**4-To start the splunk**

```
cd /opt/splunk/bin
sudo ./splunk start

```
**5-Then go to localhost:8000. You will see the login panel default username:admin password:changeme**

**6-To enable listen port for forwaders**

```
./splunk enable listen 1453

```

**7-Log files in /opt/splunk/var/log/splunk**

*If connection is ok with forwarders and you are getting data from forwarders you will see something like that:*

```
DateParserVerbose - Accepted time (Sun Sep 14 02:22:53 2014) is suspiciously far away from the previous event's time (Sun Sep 14 09:17:36 2014), but still accepted because it was extracted by the same pattern

```
**8-Adding the forwarders, first you need to download splunkforwarders.deb**

```
splunkforwarder-6.2.1-245427-linux-2.6-amd64.deb
```

**9-To install the forwarders same as before like;**

```
sudo dpkg -i splunkforwarder-6.2.1-245427-linux-2.6-amd64.deb
```

**10-Then adding files to monitor from the splunk server**

```
On forwarders
cd /opt/splunk/bin/
./splunk add forward-server <splunkserver>:<port>

//Listing forwarder, first time will showen not activated dont be panic
./splunk list forward-server

//To add files to monitor
./splunk add monitor /var/log/syslog -index main -typesource machine1-syslog

//Listing which directory or files sending to splunk server
./splunk list monitor

//This is for show your machine in client tabs in splunk web gui
./splunk set deploy-poll <splunkserver>:8089(default port)
vi /opt/splunkforwarder/etc/system/local/deploymentclient.conf
//Add those lines

[deployment-client]
clientName = machine1-forwarder

./splunk restart

```
