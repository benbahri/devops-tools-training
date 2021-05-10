#!/bin/bash
sudo yum -y install epel-release
sudo yum -y install ansible

echo "
192.168.33.10 master
192.168.33.21 node01
192.168.33.22 node02
" >> /etc/hosts

chmod 400 .ssh/id_rsa

# install necessary ansible galaxy roles
ansible-galaxy install geerlingguy.java
ansible-galaxy install infopen.openjdk-jdk
ansible-galaxy install gantsign.maven
ansible-galaxy install lrk.sonarqube
ansible-galaxy install robertdebock.artifactory
ansible-galaxy install geerlingguy.jenkins
ansible-galaxy install geerlingguy.docker
