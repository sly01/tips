**First put disk to cdrom**
```
mkdir /mnt/repo
mount /dev/sr0 /mnt/repo
```

**Then create and edit /etc/yum.repos.d/rhel.repo like this;**

```
[rhel-cd]
name=Red Hat OS CD
baseurl=file:///mnt/repo/Server
enabled=1
gpgcheck=0
```
**Then clean your cache**

```
yum clean all
```
