```
    Kerberized NFS with IPA Server direct-map and indirect-map autofs
    Make sure all kerberize and ldap stuff done then this documentation will help you.

    1-On Nfs Server Part
    Make sure nfs-server and nfs-secure-server enabled and firewalld acces those services nfs,rcp-bind,mountd

    #On Nfs Server /etc/exports something like that for direct-map
    /data/books  192.168.100.0/24(rw,sec=krb5p,no_root_squash)


    #On Client Side do this step;
    yum install autofs
    cd /etc/auto.master.d
    Then edit file as follow - vi direct.autofs
    /-    /etc/auto.direct
    Then edit file as follow - vi /etc/auto.direct
    /srv/books(where to mount)     -rw,sync,sec=krb5p      rhel7-0-server.erkoc.net:/data/books
    systemctl start autofs
    Then here we go;
    cd /srv/books and you will see it is mounted
    By the way I did this test on Redhat 7.0 and I can't see mounted point output of df


    #On NFs Server /etc/exportfs smething like that for indirect-map
    /data  *(rw,sec=krb5p,no_root_squash)

    #On Client Side do this step;
    yum install autofs (if not installed)
    cd /etc/auto.master.d
    Then edit file as follow - vi srv.autofs (be careful file extension should be autofs )
    /srv    /etc/auto.srv
    Then edit file as follow - vi /etc/auto.srv
    *   -rw,sync,sec=krb5p  rhel7-0-server.erkoc.net:/data/&
    systemctl start autofs
    Then here we go;
    cd /srv/books or /srv/articles , /srv/<whateverdirectoryitis> and you will see it is mounted
    By the way I did this test on Redhat 7.0 and I can't see mounted point output of df
```
