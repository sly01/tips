
####Nginx Maintenance Page

```
server {
        listen      80;
        server_name mysite.com;
        root    /var/www/mysite.com/;

        location / {
            if (-f $document_root/maintenance.html) {
                return 503;
           }
            ... # the rest of your config goes here
         }

        error_page 503 @maintenance;
        location @maintenance {
                rewrite ^(.*)$ /maintenance.html break;
        }
}
```