#*Setting Up a Blog With Octopress*

####You need to install git,ruby and some gems then make configuration little bit.

#####Install the git and ruby
```
For Linux Users

sudo apt-get install git ruby

For MacUsers with brew

brew install git ruby

```

**Ruby version should be at least 1.9.3**

####To upgrade the ruby version install rvm
```
\curl -sSL https://get.rvm.io | bash
source ~/.rvm/scripts/rvm
```

####Then install let's say ruby 2.0
```
rvm install 2.0
```

####Clone the octopress repo from git
```
git clone git://github.com/imathis/octopress.git octopress
```

####Install the dependencies 
**If you dont have bundler then install bundler first**
```
gem install bundler
```
```
cd octopress
bundle install
```

####Install the theme
```
rake install
```
**For themes <https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes>**

**If you type ```rake preview``` you can see the page on port 4000**
####Configure site title,author etc.
```
vi _config.yml
```

*Example*
```

url: http://sly01.github.io
title: Ahmet ERKOC Personal Web Page 
subtitle: This blog for MacOsX-Linux User and SysAdmin 
author: Ahmet ERKOC 
simple_search: https://www.google.com/search
description: Ahmet ERKOC Blog 
```

##Deploying to GithubPages

**Create a new repository name will be username.github.io**

####Setup github page repo
```
rake setup_github_pages
```
**Then type your repo. Assume that you have added your ssh key to github account.** 

##Deploying to host(VPS)

**The difference is that you just edit your Rakefile to authenticate with ssh access.**
**Assume that you have added your ssh key to your host and installed a web server nginx,apache,lighttpd etc.**

*Example*
```
ssh_user       = "user@test.com"
ssh_port       = "22"
document_root  = "/var/www/test.com/web"
rsync_delete   = false
rsync_args     = ""  # Any extra arguments to pass to rsync
deploy_default = "rsync"
```


####Create a post
```
rake new_post
```
**Type the title of post or article whatever it is :)**

####Then edit your post which is stored in source/_posts

*Example*
```
vi 2014-06-28-gpg-documentation.markdown
```
```
---
layout: post
title: "Gpg Documentation"
date: 2014-06-28 10:45:23 +0300
comments: true
categories:
---
####To install the gpg

**Linux**
```

**Written in markdowned form but you can change It to html form from Rakefile**

*Example*
```
new_post_ext    = "html"  # default new post file extension when using the new_post task
new_page_ext    = "markdown"  # default new page file extension when using the new_page task
```

####To generate and deploy the post
```
rake generate

rake deploy

or

rake gen_deploy
```
***Before the deploy the post you can see the page like this***

```
rake preview
```

#####To get all list for rake
```
rake -T
```
*If you get the error execjs something like that you need to install node-js*
```
sudo apt-get install node-js

or

brew install node
```