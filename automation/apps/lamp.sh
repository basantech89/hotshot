GREEN='\033[1;92m'
WHITE='\033[1;97m'
RED='\033[1;91m'
NC='\033[0m'	#NoColor


echo -ne "${WHITE}=============================== Installation Started =======================================${NC}"


# Installing Apache Web Server
echo -ne "${GREEN}Installing Apache Web Server${NC}"
sudo apt update
sudo apt install apache2 -y
#sudo ufw allow 'Apache'
#sudo ufw status
sudo service apache2 start

# Installing MySQL
echo -ne "${GREEN}Installing Mysql${NC}"
sudo apt install mysql-server -y
sudo service mysql start
echo -ne "${RED}Please provide information for mysql secure installation${NC}"
sudo mysql_secure_installation

# Installing PHP
echo -ne "${GREEN}Installing PHP${NC}"
sudo apt install php libapache2-mod-php php-mysql
sudo service apache2 restart
sudo service mysql restart


echo -ne "${WHITE}=============================== Installation Finished =======================================${NC}"
