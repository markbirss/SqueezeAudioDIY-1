#!/bin/bash

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /var/log/squeezeaudiodiy > /dev/null 2>&1
rm -R /usr/share/sadiy_files > /dev/null 2>&1
rm -R /usr/share/sadiy_files > /dev/null 2>&1
#MAKING NEW DIRECTORIES
mkdir /usr/share/sadiy_files
#SETUP DIRECTORY
mkdir /usr/share/sadiy_files/setup
#LOG DIRECTORY
mkdir /var/log/squeezeaudiodiy
#INSTALLERS DIRECTORIES
mkdir /usr/share/sadiy_files/installers
mkdir /usr/share/sadiy_files/installers/squeeze_latest
mkdir /usr/share/sadiy_files/installers/squeeze_include
mkdir /usr/share/sadiy_files/installers/lms_stable
mkdir /usr/share/sadiy_files/installers/lms_nightly
#TEMPORY DIRECTORY
mkdir /usr/share/sadiy_files/tmp
#SETTINGS DIRECTORIES
mkdir /usr/share/sadiy_files/settings
mkdir /usr/share/sadiy_files/settings/backups

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /dev/null 2>&1

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
cp -R ./* /usr/share/sadiy_files/setup
chmod +x /usr/share/sadiy_files/setup/scripts/sadiy_setup.sh
rm /usr/bin/squeeze_setup > /dev/null 2>&1
rm /usr/bin/sadiy_setup > /dev/null 2>&1
ln -s /usr/share/sadiy_files/setup/scripts/sadiy_setup.sh /usr/bin/squeeze_setup
ln -s /usr/share/sadiy_files/setup/scripts/sadiy_setup.sh /usr/bin/sadiy_setup

#------------------------------------
#CONFIGS FOR SQUEEZELITE LOGS
#------------------------------------
sed -i '19s:.*:SB_EXTRA_ARGS=cha-d all=debug -f /var/log/squeezeaudiodiy/squeezelite.log:' /etc/default/squeezelite
sed -i '19s:$:":' /etc/default/squeezelite
sed -i '19s:cha:":' /etc/default/squeezelite

#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
unzip ./files/squeezelite-v1.8.5-802.zip -d /usr/share/sadiy_files/installers/squeeze_include/
cd /usr/share/sadiy_files/installers/squeeze_include/squeezelite-master/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite
cp ./squeezelite /usr/bin/

#------------------------------------
#EXTRA
#------------------------------------
chmod -R 0777 /var/log/squeezeaudiodiy
chmod -R 0777 /usr/share/sadiy_files/tmp

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
