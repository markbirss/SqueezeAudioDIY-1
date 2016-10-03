#!/bin/bash

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/share/squeeze_files >/dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] OLD FILES REMOVED"
fi
#MAKING NEW DIRECTORIES
mkdir /usr/share/squeeze_files
mkdir /usr/share/squeeze_files/setup
mkdir /usr/share/squeeze_files/logs
mkdir /usr/share/squeeze_files/latest
mkdir /usr/share/squeeze_files/include
mkdir /usr/share/squeeze_files/lms
mkdir /usr/share/squeeze_files/lms/stable
mkdir /usr/share/squeeze_files/lms/nightly
echo "[ OK ] DIRECTORIES CREATED"

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/share/squeeze_files/logs/squeeze_stop1_log.txt #LOG SYSTEM

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
cp -R ./* /usr/share/squeeze_files/setup
chmod +x /usr/share/squeeze_files/setup/scripts/squeeze_setup.sh
rm /usr/bin/squeeze_setup >/usr/share/squeeze_files/logs/tools_sym_log.txt
ln -s /usr/share/squeeze_files/setup/scripts/squeeze_setup.sh /usr/bin/squeeze_setup
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
apt-get install -y unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/share/squeeze_files/logs/library_log.txt
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
service squeezelite stop > /usr/share/squeeze_files/logs/squeeze_stop2_log.txt #LOG SYSTEM

#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
cd /usr/share/squeeze_files/latest/
apt-get install -y git > /usr/share/squeeze_files/logs/git_log.txt #LOG SYSTEM
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/share/squeeze_files/latest/squeezelite/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite > /usr/share/squeeze_files/logs/rm_int_squeeze.txt #LOG SYSTEM
cp ./squeezelite /usr/bin/

#------------------------------------
#START SQUEEZELITE
#------------------------------------
cp /usr/share/squeeze_files/setup/scripts/squeeze_install.sh /usr/share/squeeze_files/
cp /usr/share/squeeze_files/setup/scripts/squeeze_install_latest.sh /usr/share/squeeze_files/
service squeezelite start
exit
