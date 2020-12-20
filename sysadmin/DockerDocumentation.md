#### Install the docker

```
sudo apt-get install docker lxc-docker

or

sudo sh -c "curl https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install lxc-docker
```

## Create a Dockefile and add the those lines;

```
FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]

```

## CMD ["-D", "FOREGROUND"]

#### then execute those commands

```
docker build -t="apache2" .

docker run -p 8080:80 -d apache2

```

**That is for running apache under docker instance. The local host machine 8080 will be bind docker instance 80 port.**
**When you type your host machine ip and forwarded port in browser you will see the it works default page of apache2.**

##### Adding content to /var/www of docker instance

```
docker run -v /home/vagrant/apache2/html/:/var/www -p 8080:80 -d apache2
```

**This will bind to /home/vagrant/apache2/html to /var/www of docker instance**

**To access to daemon container, you can use lxc-attach.**

**If it is not installed in your system just type sudo apt-get install lxc.**

_First step you will edit /etc/default/docker_

_Add this line DOCKER_OPTS="-e lxc"_

**then restart docker service as sudo service docker restart**

**And the containers docker restart <container-id>**

**To access to running container as a daemon, you will get the container id with docker ps --no-trunc**

```
Then lxc-attach -n <container id> (which is comming from docker ps --no-trunc in container id column)

To stop the all containers

docker stop $(docker ps -a -q)

To delete the all containers

docker rm $(docker ps -a -q)

```
