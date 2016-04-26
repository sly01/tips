```
    #Show current label for (ext2,ext3,ext4)
    e2label /dev/<sda,sdb..>
    or
    mount -l (end of the line you will see labels)

    #Creating label for ext2,ext3,ext4
    e2label -L <labelname> /dev/<sda,sdb,...>

    #Creating label for xfs
    xfs_admin -L <labelname> /dev/<sda,sdb>

    #You can also mount partition with label in /etc/fstab like this;
    LABEL=<label-name>      /mountpoint     <type>    <options>  <fs_freq> <fs_passno>

    #Example
    LABEL=index        /index     xfs     defaults 0 0

```
