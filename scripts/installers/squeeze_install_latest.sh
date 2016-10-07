#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

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

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
rm -R /usr/share/squeeze_files/installers/squeeze_latest
mkdir /usr/share/squeeze_files/installers/squeeze_latest
cd /usr/share/squeeze_files/installers/squeeze_latest
apt-get install -y git
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/share/squeeze_files/installers/squeeze_latest/squeezelite/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite
cp ./squeezelite /usr/bin/

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start

#------------------------------------
#GO BACK TO MENU
#------------------------------------
squeeze_setup
