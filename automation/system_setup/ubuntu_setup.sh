#!/bin/bash
apt-get update

# installing vim and ssh
apt-get -y install vim openssh-server
sed -i '/PermitRootLogin/ s/without-password/yes/' /etc/ssh/sshd_config
service ssh restart
passwd root
passwd -u root

# installing google-chrome-stable
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
apt-get -y install google-chrome-stable

# installing firefox
apt-get -y remove firefox
wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/50.0/linux-x86_64/en-US/firefox-50.0.tar.bz2
tar -xvf firefox*.bz2 -C /opt
rm -rf ~/.mozilla ~/.cache/mozilla
rm -f /usr/bin/firefox
ln -s /opt/firefox/firefox /home/ubuntu/Desktop/firefox
ln -s /opt/firefox/firefox /usr/bin/firefox

# installing virtualbox
apt-get -y install virtualbox

