```
#!/bin/bash



tarih=$(date +"%Y%m%d-%H%M")

#echo $tarih



# Our Base backup directory

BASEBACKUP="/var/www/mysqlbackup"



mysql --user=backupadm --password=password -e 'show
databases' | grep -v '^Database$'>/var/www/mysqlbackup/db-list.txt



for DATABASE in `cat /var/www/mysqlbackup/db-list.txt`

do

        # This is where we throw our backups.

        FILEDIR="$BASEBACKUP/$DATABASE"



        # Test to see if our backup directory exists.

        # If not, create it.

        if [ ! -d $FILEDIR ]

        then

                mkdir -p $FILEDIR

        fi



#        echo -n "Exporting database:  $DATABASE"

        mysqldump -uroot -pSecret --opt --single-transaction $DATABASE |
gzip -c -9 > $FILEDIR/$DATABASE-$tarih.sql.gz



done



# AutoPrune our backups.  This will find all files

# that are "MaxFileAge" days old and delete them.

MaxFileAge=4

find $BASEBACKUP -name '*.gz' -type f -mtime +$MaxFileAge -exec rm -f {} \;
```
