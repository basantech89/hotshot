#!/bin/bash

# OVD Farm Installation Script

# Adding Inuvika Repos
echo "deb http://archive.inuvika.com/ovd/2.5/ubuntu xenial main" > /etc/apt/sources.list.d/ovd.list
wget -O- "http://archive.inuvika.com/ovd/2.5/keyring" | apt-key add -
apt-get update

# OVD Application Server Installation
apt-get -y install linux-image-extra-$(uname -r) inuvika-ovd-slaveserver-role-aps inuvika-ovd-desktop

