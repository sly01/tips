	**Adding a rule to iptables in Redhat 7 **
	#firewall-cmd --zone=public --add-port=80/tcp --permanent
	#firewall-cmd --reload	
	**Deleting a rule in iptables in Redhat 7 **
	#firewall-cmd --zone=public --remove-port=80/tcp --permanent
	#firewall-cmd --reload
