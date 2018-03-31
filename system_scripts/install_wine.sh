#!/bin/sh
##script to install wine
##this script assume that local yum server and epel repos are already installed on your system
yum groupinstall -y 'Development Tools'
yum -y install libX11-devel freetype-devel zlib-devel libxcb-devel
wget ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/7.0/x86_64/os/Packages/mesa-libOSMesa-9.2.5-5.20131218.el7.x86_64.rpm
yum -y localinstall mesa-libOSMesa-9.2.5-5.20131218.el7.x86_64.rpm
yum -y install wine

