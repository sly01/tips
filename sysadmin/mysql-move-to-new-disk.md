```
#First stop mysql
service mysqld stop or systemctl stop mysqld

#Give disk to machine assume it is vm and you create volume group and lv for new disk

#There are three ways link /var/lib/mysql to new disk, mount /var/lib/mysql to new disk or change mysql datadir. If you use entire disk then go second option like I do here.

mv /var/lib/mysql /var/lib/mysql2
mkdir /var/lib/mysql
chown mysql:mysql /var/lib/mysql
chmod 755 /var/lib/mysql
#Mount new disk that I use as a lv to /var/lib/mysql which is the original directory for mysql
mount /dev/mapper/vg_mysql-lv_mysql /var/lib/mysql
cd /var/lib/mysql2
cp -rp * /var/lib/mysql
service mysqld start
tail -1 /etc/mtab >> /etc/fstab
```
