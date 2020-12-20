#### Upgrading Ubuntu 10.04 to 12.04

**First step you have to do is;**

```
sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove
```

**Second step install update manager**

```
sudo apt-get install update-manager-core
```

**Be careful about release version**

```
/etc/update-manager/release-upgrades

prompts=lts
```

**Now you are ready to upgrade**

```
do-release-upgrade
```


##### Ps

**If you get 'Command terminated with exit status 1' , you can check your /var/log/dist-upgrade/main.log, if you see something like this ERROR Unauthenticated packages found**

*Create file and edit like this*

```
/etc/update-manager/release-upgrades.d/unauth.cfg

[Distro]
AllowUnauthenticated=yes

```

**After upgrading your os then remove that file**

**Now you are ready to upgrade**

```
 do-release-upgrade
```
