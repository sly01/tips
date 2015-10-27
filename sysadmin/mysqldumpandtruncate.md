```
#!/bin/bash

tarih=$(date +"%Y%m%d-%H%M")
BASEBACKUP="/root/mysqlbackup"
database="loganalyzer"
user="root"
password="root1234"
#Get dump
mysqldump -u$user -p$password $database | gzip -9 -c  > $BASEBACKUP/$tarih.sql.gz
#Truncate all tables in database

mysql -u$user -p$password -e 'show tables' $database | while read table; do mysql -u$user -p$password -e "truncate table $table" $database ; done

```
