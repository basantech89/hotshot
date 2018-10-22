#!/bin/bash

# installing basic utilities
yum -y install epel-release
yum -y install virt-manager ntfs-3g

# installing google-chrome-stable
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum localinstall -y google*.rpm
sed -i '/HERE\/chrome"  "\$\@"/ s/$/ --user-data-dir --no-sandbox/' /usr/bin/google-chrome
# or simply do
# sed -i '55 s/$/ --user-data-dir --no-sandbox' /usr/bin/google-chrome

# installing firefox
wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/50.0/linux-x86_64/en-US/firefox-50.0.tar.bz2
yum -y remove firefox
rm -rf ~/.mozilla ~/.cache/mozilla
rm -f /usr/bin/firefox
tar -xvf firefox*.bz2 -C /opt
ln -s /opt/firefox/firefox $HOME/Desktop/firefox
ln -s /opt/firefox/firefox /usr/bin/firefox

# installing vlc
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum -y install vlc
sed -i '/geteuid/ s//getppid/' /usr/bin/vlc

# installing torrent client
yum -y install qbittorrent
