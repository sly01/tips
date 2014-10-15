###Let's assume you have three machine those are
```
puppet -> puppet master
web1   -> puppet client
web2   -> puppet client
```

###First all of edit hosts file 
**Puppet Master /etc/hosts**

```
192.168.1.10  web1
192.168.1.20  web2
```

**Clients hosts**
```
192.168.1.5  puppet
```


*To install the puppet*


**On puppet which is master puppet server**

```
sudo apt-get install puppetmaster
```

**On clients those are web1 and web2**

```
sudo apt-get install puppet
```

*Then verify the connection with ca that uses ssl ca*

**On clients  to send the ca request**

```
puppetd --test
```

*or you can edit your default puppet config file*

**edit /etc/default/puppet like this**

###Start puppet on boot?###
```
START=yes
```

**On the puppet master**

*You can see the requested ca like this*

```
puppetca --list
```

**To verify request**
```
puppetca --sign <hostName>
```
**Then clients and master know each other.**

```

Let's make a example

On Server Side

Create a file in /etc/puppet/manifes/site.pp

Edit this file like this

node 'web1.local' {
    package { "nginx": ensure=> installed }

    file { "/var/run/motd":
    source => "puppet:///files/motd"
    }
}

node 'web2.local' {
    file { "/var/run/motd":
    source => "puppet:///files/motd"
    }
}
```

*By the way first node will installed with nginx and edited motd file which is consist of some text.*
*Motd will attach the /var/run/motd. When somebody successfully login then they will the message which is located in motd.*

*Then we need to give a permission to client to access to puppet:///files/motd*

*First of all create a directory name is files if not exist*

*And create a file for motd*

*Then write something in it.*

```
Then edit the fileserver.conf like this
Be carefull allowed networks and full path
[files]
  path /etc/puppet/files
  allow 192.168.1.0/24

Then restart the puppetmaster server like this

sudo service puppetmaster restart

On client side

You just enable puppet to get the order from puppetmaster server that you have already requested. There are two way for that;

1- puppetd --test
2- Edit /etc/default/puppet like this 
```
# Start puppet on boot?
```
START=yes
```

**Those two issues you should already do that to verify the ca to puppetmaster server before.**

*That's all.*


*By the way common error here;*

*If you get error something like that ;*
*err: Could not retrieve catalog from remote server: hostname was not match with the server certificate*
*warning: Not using cache on failed catalog*
*err: Could not retrieve catalog; skipping run*

**You should correct your /etc/hosts file in both side take a look once again.**
**Probobaly there is a mistake from SSL ca name;**

```
You can see ca like this;

puppet cert print $(puppet master --configprint certname)

You will see that Subject: CN=test.example.com

If the hostname of puppet master server name is puppet. You expect like that Subject : CN=puppet This about hostname. Be careful!

Then remove ca from both sides;

rm -rf /var/lib/puppet/ssl

On server side 

service puppetmaster restart

Be sure that host name in the certificate correct

puppet cert print $(puppet master --configprint certname)
On client side 

service puppet restart
```

####Then it should work properly.
