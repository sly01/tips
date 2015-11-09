    #First check pam module is enabled or not 
    
    ldd /{,usr/}{bin,sbin}/* | grep -B 5 libpam | grep '^/'

    #Add those lines to /etc/pam.d/sshd

    auth       required     pam_tally2.so  file=/var/log/tallylog deny=3 even_deny_root unlock_time=45
    account    required     pam_tally2.so

    **It means that even root failed 3 time password lock them for 45 sec**

    #To see the failures

    pam_tally2 --user=<username>

    #To unlock the accout

    pam_tally2 --user=<username> --reset
