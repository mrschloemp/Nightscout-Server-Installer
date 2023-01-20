#!/bin/sh
#
# Nightscout Server Installer
# by Michael Schlömp
# www.michael-schloemp.de
#

launch.sh(){
# Apache stop and Purge
sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils -y
# Install Basis-Utils
sudo apt-get install ufw -y nginx -y nano -y git -y python -y gcc -y -y certbot python3-certbot-nginx -y npm -y gnupg2 -y
# UFW Configuration
sudo ufw allow 1337;
sudo ufw allow 'Nginx Full';
sudo ufw allow OpenSSH;
sudo ufw --force enable;
# Mongo installation
sudo apt update;
	sudo apt install gnupg -y;
	wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list;
	sudo apt update -y;
	sudo apt install mongodb-org -y;
	sudo systemctl start mongod;
	sudo systemctl enable mongod;
	sudo systemctl status mongod;
# break
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "${YELLOW}Kurze Pause für 5 Sekunden/Short break for 5 seconds ...${NC} \n"
hour=0
 min=0
 sec=5
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne "$hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done
# Create MongoDB Database with User and Passwort
mongo --quiet --eval "db = db.getSiblingDB('Nightscout'); db.createCollection('geekFlareCollection'); db.createUser({user: 'Mongobenutzer', pwd: 'myCgn4hmhQN639BH', roles:['readWrite']});"
# git clone
git clone https://github.com/nightscout/cgm-remote-monitor.git
# Install Nightscout
cd cgm-remote-monitor
npm install
# break
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "${YELLOW}Kurze Pause für 5 Sekunden/Short break for 5 seconds ...${NC} \n"
hour=0
 min=0
 sec=5
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne "$hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done
# Copy startsh
cp -u /home/mainuser/vollinstallation/.dateien/start.sh /home/mainuser/cgm-remote-monitor/start.sh
chmod 775 start.sh
sleep 5
# copy nightscout.service
sudo cp -u /home/mainuser/vollinstallation/.dateien/nightscout.service /etc/systemd/system/nightscout.service

}
