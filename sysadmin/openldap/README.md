####Openldap server - client installation and authentication ssh for centos 7

```
// Repo for openldap packages
yum install epel-release

// Firewall rules for ldap
firewall-cmd --permanent --zone=public --add-service=ldap
firewall-cmd --reload

//To install those packages
yum install openldap-servers openldap-clients openldap

// Configuration part
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG
systemctl start slapd
systemctl enable slapd

// To create password for password part 
slappasswd

// Make a directory for ldif files and use it these ldif files that I create for you, just change it for yourself
mkdir /root/ldif
cd /root/ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f change_rootpw.ldif

// Some schemas already coming in openldap-servers package
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif 
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/ppolicy.ldif 

// Ldap domain configuration dc=erkoc,dc=net,cn=Admin, ou=People, ou=Groups
ldapmodify -Y EXTERNAL -H ldapi:/// -f chdomain.ldif
ldapadd -Wx -D cn=admin,dc=erkoc,dc=net -f basedomain.ldif 

// Ldap search to make sure record is successfull or not ? 
ldapsearch -Wx -D cn=admin,dc=erkoc,dc=net -b "dc=erkoc,dc=net"

// Adding user, just edit adduser.ldif for your system
ldapadd -x -W -D "cn=admin,dc=erkoc,dc=net" -W -f adduser.ldif 

// Ldap logging configuration
ldapmodify -Y EXTERNAL -H ldapi:/// -f logging.ldif
echo "local4.*" >>     /var/log/slapd.log
systemctl restart rsyslog.service
systemctl restart slapd.service

// For Gui management 
yum install phpldapadmin

// Edit this file
vi /etc/phpldapadmin/config.php
    $servers->setValue('appearance','password_hash','md5');
    //$servers->setValue('appearance','password_hash','');
            to
    //$servers->setValue('appearance','password_hash','md5');
    $servers->setValue('appearance','password_hash','');

// Edit this file 
<IfModule mod_authz_core.c>
    # Apache 2.4
      Require local
      // Add this line where you connection from
      Require ip 100.100.100.100
 </IfModule>

// Login username as;
login dn: cn=admin,dc=erkoc,dc=net
password : whateveritis

systemctl restart httpd

// For ssh connection from your client or which machine do you want to connect via ldap
authconfig --enableldap --enableldapauth --ldapserver=<ip> --ldapbasedn="dc=erkoc,dc=net" --enablemkhomedir --update

// Add this line to /etc/ssh/sshd_config
PAMAuthenticationViaKbdInt yes

systemctl restart sshd

That's all :)
```
