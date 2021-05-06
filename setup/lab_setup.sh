#!/bin/bash
sudo yum -y install epel-release
sudo yum -y install ansible

echo "
10.0.0.10 ansible
10.0.0.21 node01
10.0.0.22 node02
" >> /etc/hosts

chmod 400 .ssh/id_rsa

# install necessary ansible galaxy roles
ansible-galaxy install geerlingguy.java
ansible-galaxy install infopen.openjdk-jdk
ansible-galaxy install gantsign.maven