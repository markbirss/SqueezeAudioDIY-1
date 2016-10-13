#!/bin/bash

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /var/log/squeezeaudiodiy > /dev/null 2>&1
rm -R /usr/share/sadiy_files > /dev/null 2>&1
rm -R /usr/share/sadiy_files > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] OLD FILES REMOVED"
fi
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
echo "[ OK ] DIRECTORIES CREATED"

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
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] SQUEEZELITE TOOLS INSTALLED"
  else
    echo "[ ERROR ] SQUEEZELITE TOOLS INSTALL FAILED"
fi

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get update
apt-get install -y xterm unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get install -y squeezelite
if [ $? = 0 ]
then
        echo "[ OK ] INSTALLED SQUEEZELITE VIA PACKAGE MANAGER"
else
        echo "[ ERROR ] PACKAGE MANAGER DOES NOT HAVE SQUEEZELITE"
        echo "[ ERROR ] -----------------------------------------"
        echo "[ ERROR ]      SQUEEZELITE WILL NOT AUTO START     "
        echo "[ ERROR ]      AND WILL NOT HAVE CONFIG FILES      "
        echo "[ ERROR ] -----------------------------------------"
fi
service squeezelite stop
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
