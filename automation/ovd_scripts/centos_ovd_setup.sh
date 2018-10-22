#!/bin/bash
sed -i '/SELINUX/ s/enforcing/disabled/' /etc/selinux/config
cat > /etc/yum.repos.d/ovd.repo << EOF
[ovd-2.2.0]
name=Inuvika OVD 2.2.0
baseurl=http://archive.inuvika.com/ovd/2.2/rhel/7/
enabled=1
gpgcheck=1
gpgkey=http://archive.inuvika.com/ovd/2.2/keyring
EOF
# next step is onlt for rhel 7
#subscription-manager repos --enable=rhel-7-server-optional-rpms
yum clean all
firewall-cmd --add-port={80/tcp,443/tcp,1111/tcp,1112/tcp,1113/tcp,445/tcp,3389/tcp} --permanent
firewall-cmd --reload
yum install -y mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb
mysqladmin -u root password 'qwe'
mysql -u root -p -e 'create database ovd'
yum install -y php-mbstring
yum install -y inuvika-ovd-session-manager inuvika-ovd-administration-console
ovd-session-manager-config
ovd-administration-console-config
systemctl enable httpd
systemctl restart httpd