#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/share/squeeze_files/logs/squeeze_stop1_log.txt 2>&1 #LOG SYSTEM

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get update
apt-get install -y xterm unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/share/squeeze_files/logs/library_log.txt
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
apt-get install -y squeezelite 2>&1 | tee /usr/share/squeeze_files/logs/apt_squeeze_log.txt #LOG SYSTEM
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
service squeezelite stop > /usr/share/squeeze_files/logs/squeeze_stop2_log.txt 2>&1 #LOG SYSTEM

#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
rm -R /usr/share/squeeze_files/latest
mkdir /usr/share/squeeze_files/latest
cd /usr/share/squeeze_files/latest/
apt-get install -y git > /usr/share/squeeze_files/logs/git_log.txt 2>&1 #LOG SYSTEM
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/share/squeeze_files/latest/squeezelite/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite > /usr/share/squeeze_files/logs/rm_int_squeeze.txt 2>&1 #LOG SYSTEM
cp ./squeezelite /usr/bin/

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
exit
