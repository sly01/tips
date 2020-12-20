**First create and configure team master nic**

```
nmcli con add type team con-name team0 ifname team0 config '{"runner": {"name" : "activebackup"}}'
nmcli con mod team0 ipv4.addresses <ip>(195.87.237.103/24)
nmcli con mod team0 ipv4.method static(or manual)
```

**Add slave interface to team master nic**

```
nmcli con add type team-slave con-name team-slave1 ifname em1 master team0
nmcli con add type team-slave con-name team-slave2 ifname em2 master team0
```

**To verify connection status**

```
nmcli con show
nmlic dev status
```

**To see status of team mechanism**

```
teamdctl team0 state view
```
