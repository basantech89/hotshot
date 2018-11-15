#!/bin/bash
GREEN='\033[1;92m'
WHITE='\033[1;97m'
RED='\033[1;91m'
NC='\033[0m'    #NoColor

pacman -Suyy
pacman -S vim bash-completion


echo -e "${GREEN}Installing rxvt, ranger and feh${NC}"
pacman -S rxvt-unicode ranger feh

echo -e "${GREEN}Installing xorg and xorg-xinit${NC}"
pacman -S xorg xorg-xinit

echo -e "${GREEN}Adding a new user${NC}"
source /etc/os-release
sudo useradd -m "lab" -s /bin/bash
#if [ "$ID" == "ubuntu" ]; then
#	echo "lab":"qwe" | sudo chpasswd
#else
#	echo "qwe" | sudo passwd "lab" --stdin
#fi
echo "lab":"qwe" | sudo chpasswd
