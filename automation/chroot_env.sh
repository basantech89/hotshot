echo Creating CHROOT Environment
apt-get update
apt-get install schroot debootstrap
mkdir /jail
cat >> /etc/schroot/schroot.conf << exit
[kali-rolling]
description=Kali rolling
location=/jail
priority=3
users=test
groups=sbuild
root-groups=root
exit
debootstrap --variant=buildd --arch amd64 kali-rolling /jail/ http://http.kali.org/kali
#The --arch specifies the architecture of the client system. If the architecture is different from the parent architecture, you should also pass the foreign flag!
mount proc /jail/proc -t proc
mount sysfs /jail/sysfs -t sysfs
