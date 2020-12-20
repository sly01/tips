```
If you type fdisk -l and get something like that for SAN Lun;
fdisk: cannot open /dev/sdc: Input/output error

Take look from multipah -ll;
multipath -ll
3600601602e11230062070f7f96fde511 dm-2 DGC     ,RAID 10
size=250G features='2 queue_if_no_path retain_attached_hw_handler' hwhandler='1 emc' wp=rw
|-+- policy='service-time 0' prio=4 status=active
| `- 4:0:0:0 sdb 8:16 active ready running
`-+- policy='service-time 0' prio=1 status=enabled
  `- 4:0:1:0 sdc 8:32 active ready running

Edit /etc/multipath.conf;

vi /etc/multipath.conf
multipaths {
    multipath {
            wwid        3600601602e11230062070f7f96fde511
                    alias       DP5_R10_1

    }

}

Then restart multipath services;
systemctl restart multipathd

Now make a partitions for san lun;
[root@redhat-virtualization ~]# fdisk /dev/mapper/DP5_R10_1
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0xdb61510d.

Command (m for help): p

Disk /dev/mapper/DP5_R10_1: 268.4 GB, 268435456000 bytes, 524288000 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0xdb61510d

                 Device Boot      Start         End      Blocks   Id  System

                 Command (m for help): n
                 Partition type:
                    p   primary (0 primary, 0 extended, 4 free)
                       e   extended
                       Select (default p): p
                       Partition number (1-4, default 1):
                       First sector (2048-524287999, default 2048):
                       Using default value 2048
                       Last sector, +sectors or +size{K,M,G} (2048-524287999, default 524287999):
                       Using default value 524287999
                       Partition 1 of type Linux and of size 250 GiB is set

                       Command (m for help): w
                       The partition table has been altered!

                       Calling ioctl() to re-read partition table.

                       WARNING: Re-reading the partition table failed with error 22: Invalid argument.
                       The kernel still uses the old table. The new table will be used at
                       the next reboot or after you run partprobe(8) or kpartx(8)
                       Syncing disks.

Then make kernel reread the new partition table, delete all used paths to the Lun. You can get the right device mapper device (dm-) from output of multipath -ll;
for d in /sys/block/dm-4/slaves/*; do echo "1" > $d/device/delete; done

Then rediscover them;

echo "- - -" > /sys/class/scsi_host/host0/scan
echo "- - -" > /sys/class/scsi_host/host1/scan

Finally format luns and mount to somewhere;
mkfs.<whateverfstype> /dev/mapper/DP5_R10_1
mount /dev/mapper/DP5_R10_1 /whatever

```
