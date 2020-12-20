### Server Installation

#### To add Chef repo

```
$ echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | \
    sudo tee /etc/apt/sources.list.d/opscode.list
```

#### Add GPG Key

```
$ sudo mkdir -p /etc/apt/trusted.gpg.d
$ gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
$ gpg --export packages@opscode.com | sudo tee \
    /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
```

#### If you have problem in above step

```
$ gpg --fetch-key http://apt.opscode.com/packages@opscode.com.gpg.key
$ gpg --export packages@opscode.com | sudo tee \
    /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
```

#### To active the Opscode Repo and Update the package

```
$ sudo apt-get update
$ sudo apt-get install opscode-keyring
$ sudo apt-get upgrade
```

#### To install the Chef Package

```
$ sudo apt-get install chef chef-server
```

**Specify chef-server url**

**Specify rabbitmq and webui admin password**

**Verify that those ports listen**

1. 4000(Chef-server)
2. 4040(Chef-server-webui)
3. 5984(CouchDB)
4. 5672(RabbitMQ)
5. 8983(Chef Solr)
6. Chef Expander

####Configuration for shell(knife client)

```
$ mkdir -p ~/.chef
$ sudo cp /etc/chef/validation.pem /etc/chef/webui.pem ~/.chef
$ sudo chown -R $USER ~/.chef
```

**Knife client configuration**

```
root@chefserver:/home/ubuntu# knife configure -i
WARNING: No knife configuration file found
Where should I put the config file? [/root/.chef/knife.rb]
Please enter the chef server URL: [http://chefserver:4000]
Please enter a clientname for the new client: [ubuntu]
Please enter the existing admin clientname: [chef-webui]
Please enter the location of the existing admin client's private key: [/etc/chef/webui.pem] ~/.chef/webui.pem
Please enter the validation clientname: [chef-validator]
Please enter the location of the validation key: [/etc/chef/validation.pem] ~/.chef/webui.pem
Please enter the path to a chef repository (or leave blank):
Creating initial API user...
Created client[ubuntu]
Configuration file written to /root/.chef/knife.rb
```

#### To verify knife client configuration

```
knife client list
```

#### Create a user for workstation(your computer)

```
root@chefserver:/home/ubuntu# knife client create username -d -a -f /tmp/username.pem
Created client[username]
```

**To verify**

```
knife client show username
```

#### Copy key and configure knife in workstation(your local computer)

```
mkdir ~/.chef
scp chef-server.example.com:/tmp/username.pem ~/.chef/username.pem
```

#### To install Knife to your computer

```
$ sudo gem install chef
```

#### Knife Configuration

```
knife configure
```

```
knife configure
Overwrite /Users/erkoc/.chef/knife.rb? (Y/N)Y
Please enter the chef server URL: [https://erkoc-macbook.local:443] http://10.0.47.10:4000
Please enter an existing username or clientname for the API: [erkoc] erkoc
Please enter the validation clientname: [chef-validator]
Please enter the location of the validation key: [/etc/chef-server/chef-validator.pem]
Please enter the path to a chef repository (or leave blank):
```

**To verify Configuration**

```
knife client list
```

```
knife client show chef-validator
```

#### Chef Client Installation

```
$ echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | \ sudo tee /etc/apt/sources.list.d/opscode.list
```

```
$ sudo mkdir -p /etc/apt/trusted.gpg.d
$ gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
$ gpg --export packages@opscode.com | sudo tee \
    /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
```

```
$ sudo apt-get update
$ sudo apt-get install opscode-keyring
$ sudo apt-get upgrade
```

#### To install the Chef Package

```
$ sudo apt-get install chef
```

**After that chef-server url asked**

#### Client Configuration

```
$ sudo mkdir -p /etc/chef
```

#### Copy the validation.pem from chef-server to chef-client

```
root@chefclient:/etc/chef# scp root@10.0.47.10:/etc/chef/validation.pem .
```

#### Create client.rb

```
$ knife configure client ./
```

**Then copy client.rb which is created just now to /etc/chef directory**

**Minimal content of created client.rb should be like this**

```
log_level        :info
log_location     STDOUT
chef_server_url  'http://yourchefserver.com:4000'
validation_client_name 'chef-validator'
```

#### If everything is finished then

```
sudo chef-client
```

######Test Part
**In your computer(workstation)**

```
knife cookbook create apache-tutorial-1
```

**Then show cookbook verify it created**

```
knife cookbook list
```

_If it is not exist_

**Then configure ./chef/knife.rb**

```
Add this lines
cookbook_path [ '~/cookbooks/', '~/base-cookbooks/']
```

```
vi cookbooks/apache-tutorial-1/recipes/default.rb
Add those lines

package 'apache2' do
  action :install
end

service 'apache2' do
  action [ :enable, :start ]
end

cookbook_file '/var/www/index.html' do
  source 'index.html'
  mode '0644'
end

```

```
vi cookbooks/apache-tutorial-1/files/default/index.html
Add those lines

<html>
<body>
  <h1>Hello, world!</h1>
</body>
</html>

```

```
knife cookbook upload apache-tutorial-1
```

#### Then go to chef-server panel and add the recipes to client run list

#### After that go to client

```
chef-client
```

#### Then you will see the Hello World Page in http://chefclienthost
