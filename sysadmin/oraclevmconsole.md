```
You can redirect the remote port to local using the ssh(1) command.
1) From Oracle VM Manager UI, find out the UUID of the virtual machine. For example: 0004fb0000060000e98127266687b615. 
2) Log into Oracle VM server (dom0), use xm list command to get the domain id. In this example, the domain id is 2. The VNC port number will be 59xx, starting with 5900. 
# xm list -l 2 |grep 59
(location 127.0.0.1:5900)
 
3) From your own desktop, then you can execute the command in a local shell to redirect the port to your desktop:
$ ssh -L 12345:localhost:5900 -N -f root@OVS
  
4) The "5900" port will be redirected to "12345" of your local desktop, so that you can run the following command to connect the guest console:
$ vncviewer local:12345
```
