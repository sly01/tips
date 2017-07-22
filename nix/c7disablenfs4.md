```
  #vi /etc/sysconfig/nfs
  (make this entry)
  RPCNFSDARGS='--no-nfs-version 4'
  systemctl restart nfs
```
