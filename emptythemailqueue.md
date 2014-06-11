
#Empty The Mail Queue

Command to see what's in the mail queue

```bash
sudo postqueue -p && sudo mailq
```

###Stopping the mail service  

```bash
sudo launchtl stop org.postfix.master && sudo postfix stop
```

###Command to delete everything in the mail queue
```bash
sudo postsuper -d ALL
```

###Restart the mail service:

```bash
sudo launchtl start org.postfix.master && sudo postfix stop && sudo postfix start
```

Finally, check queue again to see if it is empty or not. It should be empty. 
