    First scan added disc

    echo '- - - ' > /sys/class/scsi_host/host0/scan
    echo '- - - ' > /sys/class/scsi_host/host1/scan
    echo '- - - ' > /sys/class/scsi_host/host1/scan

    Format the added disc

    fdisk /dev/sdb

    Scan physical volumes

    pvscan

    Create physical volume

    pvcreate /dev/sdb[partition]

    pvscan

    List volume groups

    vgdisplay

    Create volume group

    vgcreate vg_weblogic	/dev/sdb[partition]

    vgdisplay

    Create logical volume in existing volume group

    lvcreate -n wldata -l totalPE vg_weblogic

    vgdisplay

    Create ext4 filesystem

    mkfs.ext4 /dev/vg_weblogic/wldata

    vi /etc/fstab

    /dev/vg_weblogic/wldata	/weblogic	ext4	defaults	1	2

    mount /weblogic

    Now test fstab is correct or not

    umount /weblogic

    mount /weblogic

    Verify mounting

    df -h
