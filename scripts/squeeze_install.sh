#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/bin/squeeze_files/logs/squeeze_stop1_log.txt #LOG SYSTEM

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/squeeze_files > /usr/bin/squeeze_files/logs/direct_log.txt
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] OLD FILES REMOVED"
fi
#MAKING NEW DIRECTORIES
mkdir /usr/bin/squeeze_files
mkdir /usr/bin/squeeze_files/setup
mkdir /usr/bin/squeeze_files/logs
echo "[ OK ] DIRECTORIES CREATED"

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
cp -R ./* /usr/bin/squeeze_files/setup
chmod +x /usr/bin/squeeze_files/setup/scripts/squeeze_setup.sh
rm /usr/bin/squeeze_setup > /usr/bin/squeeze_files/logs/tools_sym_log.txt
ln -s /usr/bin/squeeze_files/setup/scripts/squeeze_setup.sh /usr/bin/squeeze_setup
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
apt-get -y install ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
else
  echo "[ ERROR ] LIBRARIES INSTALL FAILED"
fi

#------------------------------------
#GIT
#------------------------------------
apt-get -y install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] GIT INSTALLED"
  else
    echo "[ ERROR ] GIT INSTALL FAILED"

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get -y install squeezelite 2>&1 | tee /usr/bin/squeeze_files/logs/apt_squeeze_log.txt #LOG SYSTEM
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
service squeezelite stop > /usr/bin/squeeze_files/logs/squeeze_stop2_log.txt #LOG SYSTEM

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
cd /usr/bin/squeeze_files/
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/squeeze_files/squeezelite
OPTS="-DDSD -DRESAMPLE -DALSA" make
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LATEST SQUEEZELITE COMPILED"
  else
    echo "[ ERROR ] LATEST SQUEEZELITE COMPILING FAILED"
fi

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
rm /usr/bin/squeezelite > /usr/bin/squeeze_files/logs/rm_int_squeeze.txt
ln -s /usr/bin/squeeze_files/squeezelite/squeezelite /usr/bin/squeezelite
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] SYMBOLIC LINKS CREATED"
  else
    echo "[ ERROR ] CREATING OF SYMBOLIC FAILED"
fi

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
exit
