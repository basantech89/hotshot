#!/bin/bash

echo ----------------------- This script install additional components to a freshly installed rhel server ------------------------------------

echo Installing basic utilities
echo Install epel repo and ntfs-3g
#rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum -y install ntfs-3g

echo Creating a local yum server
mkdir -p /Data/server
mount -t iso9660 -o loop,ro /Data/rhel-server-7.2-x86_64-dvd.iso /mnt
cp -r /mnt/* /Data/server
umount /mnt
cat > /etc/yum.repos.d/server.repo << EOF
[server]
name=main server
baseurl=file:///Data/server
gpgcheck=0
enabled=1
EOF

echo Installing virtual machine cli handler
yum -y install virt-manager

echo Installing google-chrome-stable
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
rpm -ivh google-chrome*.rpm
sed -i '/HERE\/chrome"  "\$\@"/ s/$/ --user-data-dir --no-sandbox/' /usr/bin/google-chrome
# or simply do
# sed -i '55 s/$/ --user-data-dir --no-sandbox' /usr/bin/google-chrome

echo Installing firefox
wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/50.0/linux-x86_64/en-US/firefox-50.0.tar.bz2
yum -y remove firefox
rm -rf ~/.mozilla ~/.cache/mozilla
rm -f /usr/bin/firefox
tar -xvf firefox*.bz2 -C /opt
ln -s /opt/firefox/firefox $HOME/Desktop/firefox
ln -s /opt/firefox/firefox /usr/bin/firefox

echo Installing nux-dextop repo and VLC media player and customizing it to run as root
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
rpm -Uvh ftp://ftp.pbone.net/mirror/li.nux.ro/download/nux/dextop/retired/libfribidi-0.19.2-3.el7.nux.x86_64.rpm
rpm -Uvh ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/7.3/x86_64/os/Packages/libGLEW-1.10.0-5.el7.x86_64.rpm
rom -Uvh ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/7.2/x86_64/os/Packages/minizip-1.2.7-15.el7.x86_64.rpm
yum install -y vlc
sed -i 's/euid/ppid/g' /usr/bin/vlc

echo Installing torrent client
yum -y install qbittorrent ntfsprogs

echo Installing ftp server
yum -y install vsftpd
sed -i '/local_enable/alocal_root=/root' /etc/vsftpd/vsftpd.conf
setsebool ftp_home_dir on
firewall-cmd --add-service=ftp
sed -i '/root/d' /etc/vsftpd/user_list
sed -i '/root/d' /etc/vsftpd/ftpusers
mkdir /root/Downloads/ftp_uploads
chown -R root:ftp /root/Downloads/ftp_uploads
chmod -R 666 /root/Downloads/ftp_uploads
systemctl start vsftpd
systemctl enable vsftpd

echo Installing ssh server
sed -i '49 s/#//' /etc/shh/sshd_config
firewall-cmd --add-service=sshd
systemctl start sshd
systemctl enable sshd

echo Reloading Firewall
firewall-cmd --reload

echo Status for services
systemctl status vsftpd
systemctl status sshd

echo -------------------------------------------------------- THE END ---------------------------------------------------------------------
