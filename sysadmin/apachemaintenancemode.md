1. Create your own maintance page
let's say maintance.html
put these page which host you want to get under maintenance
```
cp maintance.html /var/www/test.com
```

2. Edit AllowOverride in the */var/www/sites-available/test.com/default*
/var/www/sites-available/test.com directory block change **AllowOverride None to AllowOverride All**

3. Enable rewrite mod
```
a2enmod mod_rewrite.so
```
If a2enmod command doesn't find then hit
```
apt-get install apache2-common
```

4. Then which host you get the under maintance go to that directory like
```
cd /var/www/test.com
```
Edit .htaccess if it doesn't exist then create .htaccess as follow
```
Options +FollowSymlinks
RewriteEngine on
RewriteCond %{REQUEST_URI} !/maintance.html$
RewriteRule $ /maintance.html [R=302,L]
```

5. Restart the apache server

```
/etc/init.d/apache2 restart
```

6. Then go to test.com or test.com/* whereever you go it redirects to test.com/maintance.html

Or easy way but I prefer the first one
```
mkdir maintenance /var/www
```

create your maintenance.html and change the name index.html


then go to /etc/apache2/sites-available/default

Change DocumentRoot /var/www/maintance -> but it takes all host(virtual hosts) under maintance !
