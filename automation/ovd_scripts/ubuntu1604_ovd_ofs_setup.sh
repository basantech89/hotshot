#!/bin/bash

# OVD Farm Installation Script

# Adding Inuvika Repos
echo "deb http://archive.inuvika.com/ovd/2.5/ubuntu xenial main" > /etc/apt/sources.list.d/ovd.list
wget -O- "http://archive.inuvika.com/ovd/2.5/keyring" | apt-key add -
apt-get update

# OVD File Server Installation
apt-get -y install inuvika-ovd-slaveserver-role-fs

