#!/bin/bash

#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
        echo "Running as root."
else
        echo "Run script as root."
        exit
fi

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /Squeezelite
mkdir /Squeezelite
mkdir /Squeezelite/logs
echo "Directories created."

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential > /Squeezelite/logs/library_log.txt
echo "Installed required libraries."

#------------------------------------
#GIT
#------------------------------------
apt-get install git > /Squeezelite/logs/git_log.txt
echo "Git is installed"

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get install squeezelite > /Squeezelite/logs/apt_squeeze_log.txt
echo "Installed Squeezelite using package manager."

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop
echo "Stopped Squeezelite process."

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
echo "Compiling latest Squeezelite:"
cd /Squeezelite
git clone https://github.com/ralph-irving/squeezelite.git
cd /Squeezelite/squeezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
echo "Creating symbolic links."
cd /usr/bin
mv squeezelite ./squeezelite.bac
ln -s /Squeezelite/squeezelite/squeezelite squeezelite

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."
exit
