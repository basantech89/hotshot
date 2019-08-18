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


echo -e "${GREEN}Enabling copy-paste feature for urxvt terminal${NC}"
sudo pacman -Sy xclip
cat > /usr/lib/urxvt/perl/clipboard << EOF
#script to copy/paste text in URXVT
#! perl
sub on_sel_grab {
    my $query = $_[0]->selection;
        open (my $pipe,'| /usr/bin/xclip -in -selection clipboard') or die;
            print $pipe $query;
                close $pipe;
            }
        sub paste {
            my ($self) = @_;
                my $content = `/usr/bin/xclip -loop 1 -out -selection clipboard` ;
                    $self->tt_write ($content);
                }
            sub on_user_command {
                my ($self, $cmd) = @_;
                    if ($cmd eq "clipboard:paste") {
                                $self->paste;
                                    }
                            }
end
EOF

cp ~/.Xresources ~/.Xresources.bak
cat >> ~/.Xresources << EOF
URxvt.keysym.Shift-Control-V: perl:clipboard:paste
URxvt.iso14755: False
URxvt.perl-ext-common: default,clipboard
EOF


echo -e "${GREEN}copy paste functionality for urxvt terminal is enabled, enjoy!!${NC}"
