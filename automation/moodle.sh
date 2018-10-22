GREEN='\033[1;92m'
WHITE='\033[1;97m'
RED='\033[1;91m'
NC='\033[0m'	#NoColor


echo -ne "${WHITE}=============================== Installation Started =======================================${NC}"

# Installing php modules needed for moodle
echo -ne "${GREEN}Downloading and extracting moodle under /var/www/html and some php modules for it${NC}"
sudo apt install -y php-cli php-gd php-curl php-intl php-zip php7.0-xml
sudo wget https://download.moodle.org/stable35/moodle-latest-35.tgz	# Downloading moodle
sudo tar -xvf moodle-*.tgz -C /var/www/html	# Extracting it

# Creating a new database for moodle
echo -ne "${GREEN}Creating a new database \"moodle\" for moodle${NC}"
sudo mysql -u root -proot <<queries
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodleuser'@'localhost' IDENTIFIED BY 'moodle';
queries

# Creating a data directory to hold moodle files
echo -ne "${GREEN}Creating a data directory to hold moodle files under /var/www${NC}"
sudo mkdir /var/www/moodledata
sudo chmod 0777 /var/www/moodledata

# Installing moodle
echo -ne "${GREEN}Installing moodle${NC}"
sudo chown www-data /var/www/html/moodle
echo -ne "${RED}Please provide the information to install moodle${NC}"
sudo /usr/bin/php /var/www/html/moodle/admin/cli/install.php

# Set up cron
sudo apt install -y cron
crontab -l > mycron
echo "* * * * *    /usr/bin/php /path/to/moodle/admin/cli/cron.php >/dev/null" >> mycron
crontab mycron
sudo rm mycron

echo -ne "${WHITE}============================= Installation Finished ============================================${NC}"
