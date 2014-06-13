Stop the MySQL Server.
sudo /etc/init.d/mysql stop

Start the mysqld configuration.
sudo mysqld --skip-grant-tables &

Login to MySQL as root.
mysql -u root mysql

Replace YOURNEWPASSWORD with your new password!
UPDATE user SET Password=PASSWORD('YOURNEWPASSWORD') WHERE User='root'; FLUSH PRIVILEGES; exit;
