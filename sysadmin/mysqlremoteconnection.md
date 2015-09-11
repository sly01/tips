	Let's assume that server ip 192.168.2.5 and client ip 192.168.5.10
	
	In the server part
	
	mysql -u root -p
	password:
	
	mysql> use mysql
	mysql> grant all on *.* to root@'192.168.2.10' identified by 'root-password';
	mysql> FLUSH PRIVILEGES;
	mysql> \q
	
	mysql.server restart
	
	Check that mysql port is working or not ? Default port 3306 
	Check the firewall -> iptables -L allow to connect from 192.168.2.10 to 3306 port
	
	In the client part
	
	$mysql -h host(192.168.2.5) -u root -p
	
	After that it is all up to you :)
