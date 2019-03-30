#!/bin/bash
GREEN='\033[1;92m'
WHITE='\033[1;97m'
RED='\033[1;91m'
NC='\033[0m'    #NoColor

pacman -Suyy
pacman -S vim bash-completion


echo -e "${GREEN}Installing rxvt, ranger and feh${NC}"
pacman -S rxvt-unicode ranger feh

echo -e "${GREEN}Adding a new user${NC}"
source /etc/os-release
useradd -m "lab" -s /bin/bash
#if [ "$ID" == "ubuntu" ]; then
#	echo "lab":"qwe" | sudo chpasswd
#else
#	echo "qwe" | sudo passwd "lab" --stdin
#fi
echo "lab":"qwe" | sudo chpasswd
su - lab

echo -e "${GREEN}Installing xorg xorg-xinit, i3, dmenu, and a graphical login manager${NC}"
sudo pacman -S xorg xorg-xinit i3 dmenu lxdm-gtk3 xorg-apps
sudo systemctl enable lxdm
#startx

echo -e "${GREEN} Configuring Wireless ${NC}"
wifi-menu
sudo netctl enable wifi

echo -e "${GREEN} Configuring Screen Resolution ${NC}"
xrandr
# xrandr --output <source_name> --mode 2560x1440 --rate <refresh_rate>	#fixme

echo -e "${GREEN} Installing Pacaur ${NC}"
cd ~
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

sudo pacman -S expac yajl git

curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg PKGBUILD --skippgpcheck --install --needed

curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg PKGBUILD --install --needed

cd ~
rm -r /tmp/pacaur_install

echo -e "${GREEN} Installing Pywal ${NC}"
sudo pacman -S feh imagemagick python-pip python-pywal
cd ~
mkdir -p ~/Pictures/Wal/
mv ~/bg1.jpg ~/Pictures/Wal/
wal -i ~/Pictures/Wal/bg1.jpg

echo -e "${GREEN} Installing Polybar ${NC}"
sudo pacman -S python2 jsoncpp
pacaur -S polybar-git

echo -e "${GREEN} Installing DotFiles ${NC}"
cd ~
git clone https://github.com/IbrahimButt/direwolf-arch-rice.git
cp -r ~/direwolf-arch-rice/.config/ ~/

cp -r ~/direwolf-arch-rice/.Xresources ~/
xrdb .Xresources

wal -i ~/Pictures/Wal/bg1.jpg

echo -e "${GREEN} Installing Fonts ${NC}"
sudo pacaur -S otf-overpass

echo -e "${GREEN} Previwing images in ranger ${NC}"
sudo pacman -S w3m
ranger --copy-config=scope

echo -e "${GREEN} Installing Neofetch ${NC}"
neofetch --w3m --source ~/Pictures/Wal/bg1.jpg

echo -e "${GREEN} Activating Polybar ${NC}"
# replace DPI-8 with blablabla
polybar bar

echo -e "${GREEN} Installing Compton ${NC}"
sudo pacman -S compton

echo -e "${GREEN} Post Installation ${NC}"
sudo pacman -S alsa-utils gdisk pcmanfm networkmanager firefox xorg-drivers rxvt-unicode-terminfo terminfo xf86-input-synaptics pulseaudio pulseaudio-alsa mesa xorg-twm xf86-video-intel deepin-gtk-theme deepin-icon-theme lxappearance 
pacaur -y google-chrome


echo -e "${GREEN} Enabling Touchpad ${NC}"
echo "Section "InputClass"
    Identifier "touchpad"
    Driver "synaptics"
    MatchIsTouchpad "on"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertEdgeScroll" "on"
        Option "VertTwoFingerScroll" "on"
        Option "HorizEdgeScroll" "on"
        Option "HorizTwoFingerScroll" "on"
        Option "CircularScrolling" "on"
        Option "CircScrollTrigger" "2"
        Option "EmulateTwoFingerMinZ" "40"
        Option "EmulateTwoFingerMinW" "8"
        Option "CoastingSpeed" "0"
        Option "FingerLow" "30"
        Option "FingerHigh" "50"
        Option "MaxTapTime" "125"
EndSection" >> /etc/X11/xorg.conf.d/70-synaptics.conf
