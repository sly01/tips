	sysctl -w net.ipv4.ip_forward=1
	or
	echo 1 > /proc/sys/net/ipv4/ip_forward
	
	Permanent configuration
	
	edit /etc/sysctl.conf:
	net.ipv4.ip_forward = 1
	
	then 
	
	sysctl -p /etc/sysctl.conf
	
	For Redhat
	service network restart
	
	On debian/ubuntu
	
	/etc/init.d/procps.sh restart
	
