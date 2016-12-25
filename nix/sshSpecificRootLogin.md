```
Edit /etc/ssh/sshd_config

Match Address <ip>
        PermitRootLogin yes

Another way of doing specific users from specific ip

AllowUsers <username>@<host>

After editing sshd_config and to make configuration effective restart ssh daemon;
service sshd restart
or
systemctl restart sshd
```
