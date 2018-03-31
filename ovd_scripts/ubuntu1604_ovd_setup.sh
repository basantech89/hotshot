#!/bin/bash

# OVD Farm Installation Script

# Adding Inuvika Repos
echo "deb http://archive.inuvika.com/ovd/2.5/ubuntu xenial main" > /etc/apt/sources.list.d/ovd.list
wget -O- "http://archive.inuvika.com/ovd/2.5/keyring" | apt-key add -
apt-get update

# OVD Session Manager Installation
apt-get install -y mysql-server
mysql -u root -p -e 'create database ovd'
apt-get -y install inuvika-ovd-session-manager inuvika-ovd-administration-console

# OVD Application Server Installation
apt-get -y install linux-image-extra-$(uname -r) inuvika-ovd-slaveserver-role-aps inuvika-ovd-desktop

# OVD File Server Installation
apt-get -y install inuvika-ovd-slaveserver-role-fs

# OVD Web Access Installation 
apt-get -y install inuvika-ovd-web-access 

#apt-get -y install inuvika-ovd-applets
