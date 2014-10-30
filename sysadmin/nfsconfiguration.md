####In the server part
```
1-apt-get install nfs-common-kernel

2-Edit /etc/exports

/sharingDirectory 	ipRangeWhichWillAccesstheThisDirectory
```
**Example**

```
/home		192.168.2.0/24(rw,root_squash)

This will share home directory for 192.168.2.0/24

/etc/init.d/nfs-kernel-server restart
```

####In the client part

```
For linux users

sudo mount -t nfs serverip:/sharingDirectory /mountPoint

For mac users

sudo mount_nfs -o resvport(for security reason) serverip:/sharingDirectory /mountPoint
```

**For umount just type**

*sudo umount /mountedPoint*
