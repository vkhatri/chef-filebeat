You need Vagrant and VirtualBox to follow these

- checkout https://github.com/elastic/beats (currently at commit 5bc18eae9044f44806813926346401550e925513)  
- vagrant up solaris 
- vagrant ssh solaris (or the name of the vm you created)
- export GO15VENDOREXPERIMENT=1
- export GOROOT=/go
- export GOPATH=/export/home/vagrant/go
- export PATH=/export/home/vagrant/go/bin:/go/bin:/usr/bin:/usr/sbin
- cd /export/home/vagrant/go/src/github.com/elastic/beats/filebeat
- gmake
- tar -cvf filebeat-<version>-solaris.tar.gz filebeat filebeat.yml filebeat.template.json (or use gtar)

use filebeat-<version>-solaris.tar.gz to install filebeat
