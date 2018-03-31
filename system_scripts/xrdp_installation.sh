#!/bin/bash
apt-get install -y xrdp xfce4 xfce4-terminal gnome-icon-theme-full tango-icon-theme
echo xfce4-session > ~/.xsessions
sed -i '7 istartxfce4' /etc/xrdp/startwm.sh
service xrdp restart
