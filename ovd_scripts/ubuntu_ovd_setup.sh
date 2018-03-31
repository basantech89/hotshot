#!/bin/bash
echo "deb http://archive.inuvika.com/ovd/2.2/ubuntu trusty main" > /etc/apt/sources.list.d/ovd.list
wget -O- "http://archive.inuvika.com/ovd/2.2/keyring" | apt-key add -
apt-get update
# Installing mysql serevr, session-manager, app and file servers
apt-get install -y mysql-server
mysql -u root -p -e 'create database ovd'
apt-get -y install inuvika-ovd-session-manager inuvika-ovd-administration-console 
apt-get -y install linux-image-extra-$(uname -r) inuvika-ovd-slaveserver-role-aps inuvika-ovd-desktop 
apt-get -y install inuvika-ovd-slaveserver-role-fs 
apt-get -y install inuvika-ovd-web-access 
apt-get -y install inuvika-ovd-applets
