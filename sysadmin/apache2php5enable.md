
# Enable php5 on specific directory

```bash
sudo apt-get install php5
```

then

```bash
vi /etc/apache2/sites-available/*
```

then go to which paths you want disable add

```bash
php_admin_value engine Off
```