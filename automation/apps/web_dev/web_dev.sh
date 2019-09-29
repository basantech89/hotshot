#!/usr/bin/env bash
# Set/Reset
RESET='0'
BOLD='1'
DIM='2'
UNDERLINE='4'
BLINK='5'
HIGHLIGHT='7'
HIDDEN='8'

# FOREGROUND
BLUE='\033[1;4;7;34m'
YELLOW='\033[1;4;7;33m'
PURPLE='\033[1;4;7;35m'
CYAN='\033[1;4;7;36m'
GREEN='\033[1;4;7;92m'
WHITE='\033[1;4;7;97m'
RED='\033[1;4;7;91m'
NC='\033[0m'    #NoColor

HEAD1=${BLUE}
HEAD2=${PURPLE}
HEAD3=${CYAN}
HEAD4=${YELLOW}

echo "Press Y|y for yes, n|N for No"
printf "Do you want to install Nodejs ? "
while read -r node; do
	case "$node" in
		["Yy"]) printf "y"; break ;;
		["Nn"]) printf "n"; break ;;
		*) printf "Incorrect input, Press Y|y for yes, n|N for No "
	esac
done

printf "Do you want to install git ? "
while read -r git; do
	case "$git" in
		["Yy"]) printf "y"; break ;;
		["Nn"]) printf "n"; break ;;
		*) printf "Incorrect input, Press Y|y for yes, n|N for No "
	esac
done

printf "Do you want to install Google Cloud SDK ? "
while read -r gsdk; do
	case "$gsdk" in
		["Yy"]) printf "y"; break ;;
		["Nn"]) printf "n"; break ;;
		*) printf "Incorrect input, Press Y|y for yes, n|N for No "
	esac
done

nodejs-install() {
  echo -e "${HEAD2} [1/3] Installing Nodejs ${NC}"
  echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"
  sudo apt install nodejs -y |& tee node-installation-log.txt
  sudo apt install npm -y |& tee npm-installation-log.txt
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
}

git-install() {
  echo -e "${HEAD2} [2/3] Installing GIT ${NC}"
  echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"
  sudo apt install git -y |& tee git-installation-log.txt
	echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
}

gcloud-install() {
  echo -e "${HEAD2} [3/3] Installing Google Cloud SDK ${NC}"
  echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"

	echo -e "${HEAD3} Add the Cloud SDK distribution URI as a package source ${NC}"
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

	echo -e "${HEAD3} Import the Google Cloud Platform public key ${NC}"
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

  echo -e "${HEAD3} Update the package list and install the Google Cloud SDK ${NC}"
  sudo apt update && sudo apt install google-cloud-sdk -y |& tee gcloud-installation-log.txt

  echo -e "${HEAD4} Initializing the Google Cloud SDK ${NC}"
  glcoud init --console-only

	echo -e "${HEAD2} ===================================  ###  =================================== ${NC}"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
	echo -ne "\n"
}

echo -e "${HEAD1} =============  START: Web Development Environment Installation  ============= ${NC}"
echo -e "${HEAD1} ===================================  ###  =================================== ${NC}"
echo -e "${HEAD1} ===================================  ###  =================================== ${NC}"


if ! dpkg -s apt > /dev/null; then
    sudo apt install apt -y
fi

if ! dpkg -s curl > /dev/null; then
    sudo apt install curl -y
fi

if [ "$node" == "Y" -o "$node" == "y" ]; then
  nodejs-install
fi

if [ "$git" == "Y" -o "$git" == "y" ]; then
  git-install
fi

if [ "$gsdk" == "Y" -o "$gsdk" == "y" ]; then
	gcloud-install
fi


echo -e "${HEAD1} ===================================  ###  =================================== ${NC}"
echo -e "${HEAD1} ===================================  ###  =================================== ${NC}"
echo -e "${HEAD1} ==============  END: Web Development Environment Installation  ============== ${NC}"