```
    when you get problem like that;
    ssh root@10.10.10.10
    Unable to negotiate with 10.10.10.10 port 22: no matching key exchange method found. Their offer: diffie-hellman-group1-sha1
    Then you should specify which cipher type to use
    For example;
    ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 root@10.10.10.10
```
