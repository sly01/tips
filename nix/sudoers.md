```
For all command access;
testuser ALL=(ALL:ALL) ALL

For specific command access;
testuser ALL= (ALL) NOPASSWD: /sbin/poweroff

More efficient way;
User_Alias Users = testuser,auser,buser
Cmnd_Alias Commands = /sbin/poweroff, /sbin/ifconfig

Users ALL = (ALL) NOPASSWD: Commands

Dont forget put sudo before command;
testuser@machine1 ~ $ sudo ifconfig
```
