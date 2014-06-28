For linux(debian/ubuntu) users
sudo apt-get install nginx

Docroot: /usr/share/nginx/www

Enabling php5

apt-get install php5-fpm

Edit /etc/nginx/sites-available/default

Uncomment those;

location ~ \.php$ {
fastcgi_split_path_info ^(.+\.php)(/.+)$;
fastcgi_pass 127.0.0.1:9000;
fastcgi_index index.php;
include fastcgi_params;
}