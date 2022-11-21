#!/bin/bash

VERSION=1449
DEST="/opt/terraria-server/"
CFG="${DEST}/Server.cfg"




# Install prerequisites
sudo apt-get install -y mono-complete tmux wget unzip

# Download and unzip
wget "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip"
unzip terraria-server-${VERSION}.zip




# Move needed files away, remove unneeded files
sudo mkdir -p "${DEST}"
sudo chown -R $USER "${DEST}"
sudo chgrp -R $USER "${DEST}"
cp -r "$(pwd)/${VERSION}/Linux"/* "${DEST}"
rm -rf "${VERSION}/"
rm "terraria-server-${VERSION}.zip"
cd "${DEST}"
rm System* Mono* monoconfig mscorlib.dll




WORLDPATH="${DEST}Worlds"
mkdir -p "$WORLDPATH"

# Setup server config file
echo "Creating config file..."

#    Static values
echo "worldpath=${WORLDPATH}" >> "$CFG"
echo "secure=1" >> "$CFG"


#    Prompt values
#          Prompt user, add default value if necessary, add to cfg file
prompt() {
  config_command=$1
  prompt=$2
  default_value=$3
  read -p "$prompt [$default_value]: " user_input
  echo "${config_command}=${user_input:-$default_value}" >> "$CFG"
}

prompt autocreate "World size (1: small, 2: medium, 3: large)" 1
prompt worldname "World name" World
prompt difficulty "Difficulty (0: classic, 1: expert, 2: master, 3: journey)" 0
prompt maxplayers "Max players (1-255)" 16
prompt port "Port" 7777
prompt language "Server language (Available options: en-US, de-DE, it-IT, fr-FR, es-ES, ru-RU, zh-Hans, pt-BR, pl-PL)" en-US
prompt upnp "Automatically attempt to port-forward (1: yes, 0: no)" 1 
echo "world=${WORLDPATH}/${worldname}.wld" >> "$CFG"


#    Optional values
read -sp "Password (leave empty for none. WARNING: will be stored insecurely/plaintext): " password
if [ -z "$password" ]
then
  echo "No password set!"
else
  echo "password=${password}" >> "$CFG"
  echo "Password set!"
fi

read -p "Message of the day (leave empty for none): " motd
if [ -z "$motd" ]
then
  echo "No MOTD set!"
else
  echo "motd=${motd}" >> "$CFG"
  echo "MOTD set!"
fi


#    Values that can be set later for advanced users/specific cases
echo "#seed=RandomSeed" >> "$CFG"
echo "#banlist=banlist.txt" >> "$CFG"
echo "#npcstream=60" >> "$CFG"
echo "#priority=1" >> "$CFG"
echo "# From the wiki (https://terraria.fandom.com/wiki/Server#serverconfig): Journey Mode power permissions for every individual power. 0: Locked for everyone, 1: Can only be changed by host, 2: Can be changed by everyone."
echo "#journeypermission_time_setfrozen=2" >> "$CFG"
echo "#journeypermission_time_setdawn=2" >> "$CFG"
echo "#journeypermission_time_setnoon=2" >> "$CFG"
echo "#journeypermission_time_setdusk=2" >> "$CFG"
echo "#journeypermission_time_setmidnight=2" >> "$CFG"
echo "#journeypermission_godmode=2" >> "$CFG"
echo "#journeypermission_wind_setstrength=2" >> "$CFG"
echo "#journeypermission_rain_setstrength=2" >> "$CFG"
echo "#journeypermission_time_setspeed=2" >> "$CFG"
echo "#journeypermission_rain_setfrozen=2" >> "$CFG"
echo "#journeypermission_wind_setfrozen=2" >> "$CFG"
echo "#journeypermission_increaseplacementrange=2" >> "$CFG"
echo "#journeypermission_setdifficulty=2" >> "$CFG"
echo "#journeypermission_biomespread_setfrozen=2" >> "$CFG"
echo "#journeypermission_setspawnrate=2" >> "$CFG"



# Create systemd services for automatic startup periodic & save
cd /etc/systemd/system/

#     Terraria Server automatic start & shutdown
sudo wget https://raw.githubusercontent.com/Denperidge/terraria-raspbian-server/main/systemd/terraria.server.service

#     Terraria periodic save
sudo wget https://raw.githubusercontent.com/Denperidge/terraria-raspbian-server/main/systemd/terraria.server.save.service
sudo wget https://raw.githubusercontent.com/Denperidge/terraria-raspbian-server/main/systemd/terraria.server.save.timer

# Reload systemd daemon, enable service & timer
sudo systemctl daemon-reload
sudo systemctl enable terraria.server.service && sudo systemctl start terraria.server.service
sudo systemctl enable terraria.server.save.timer && sudo systemctl start terraria.server.save.timer


