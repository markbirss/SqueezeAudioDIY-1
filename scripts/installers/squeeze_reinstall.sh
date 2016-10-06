#!/bin/bash

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop &>> /usr/share/squeeze_files/logs/squeeze_re-install/$logname #LOG SYSTEM

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get update
apt-get install -y xterm unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/share/squeeze_files/logs/squeeze_re-install/$logname #LOG SYSTEM
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
else
  echo "[ ERROR ] LIBRARIES INSTALL FAILED"
fi

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get install -y squeezelite 2>&1 | tee /usr/share/squeeze_files/logs/squeeze_re-install/$logname #LOG SYSTEM
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
service squeezelite stop &>> /usr/share/squeeze_files/logs/squeeze_re-install/$logname #LOG SYSTEM

#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
rm -R /usr/share/squeeze_files/installers/squeeze_include
mkdir /usr/share/squeeze_files/installers/squeeze_include
unzip /usr/share/squeeze_files/setup/files/squeezelite-v1.8.5-802.zip -d /usr/share/squeeze_files/installers/squeeze_include
cd /usr/share/squeeze_files/installers/squeeze_include/squeezelite-master/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite &>> /usr/share/squeeze_files/logs/squeeze_re-install/$logname #LOG SYSTEM
cp ./squeezelite /usr/bin/

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
exit
