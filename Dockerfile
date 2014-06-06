FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]


then execute those commands

docker build -t="apache2" .

docker run -p 8080:80 -d apache2

That is for running apache  under docker instance. The local host machine 8080 will be bind docker instance 80 port.
When you type your host machine ip and forwarded port in browser you will see the it works default page of apache2.

Adding content to /var/www of docker instance 

docker run -v /home/vagrant/apache2/html/:/var/www -p 8080:80 -d apache2

This will bind to /home/vagrant/apache2/html to /var/www of docker instance
