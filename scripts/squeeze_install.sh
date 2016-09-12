#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/bin/Squeezelite/logs/squeeze_stop1_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
  tput setaf 3; echo "Squeezelite stopped."
else
  tput setaf 3; echo "No previous version of Squeezelite."
fi

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/Squeezelite
directoryquery=$($?)
if [ directoryquery = 0 ]
then
  tput setaf 3; echo "Old files removed."
else
  tput setaf 3; echo "No previous installation found."
fi
#MAKING NEW DIRECTORIES
mkdir /usr/bin/Squeezelite
mkdir /usr/bin/Squeezelite/setup
mkdir /usr/bin/Squeezelite/logs
tput setaf 3; echo "Directories created."

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
tput setaf 3; echo "Installing Squeezelite tools."
cp -R ./* /usr/bin/Squeezelite/setup
chmod +x /usr/bin/Squeezelite/setup/setup.sh
tput setaf 3; echo "Squeezelite tools installed."

#------------------------------------
#SYMLINKS FOR SQUEEZE TOOLS
#------------------------------------
rm /usr/bin/squeeze_setup > /usr/bin/Squeezelite/logs/tools_sym_log.txt
ln -s /usr/bin/Squeezelite/setup/setup.sh /usr/bin/squeeze_setup
tput setaf 3; echo "Squeezelite tools active."

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
tput setaf 3; echo "Installing required libraries."
tput setaf 7; apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
tput setaf 3; echo "Installed required libraries."

#------------------------------------
#GIT
#------------------------------------
tput setaf 3; echo "Updating Git"
tput setaf 7; apt-get install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
tput setaf 3; echo "Done updating Git."

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
tput setaf 3; echo "Installing Squeezelite using package manager."
tput setaf 7; apt-get install squeezelite 2>&1 | tee /usr/bin/Squeezelite/logs/apt_squeeze_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
        tput setaf 3; echo "Installed Squeezelite using package manager."
else
        tput setaf 3; echo "Package manager does not have Squeezelite"
        tput setaf 3; echo "-----------------------------------------"
        tput setaf 3; echo "     Squeezelite will not auto start     "
        tput setaf 3; echo "     and will not have config files.     "
        tput setaf 3; echo "-----------------------------------------"
fi

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/bin/Squeezelite/logs/squeeze_stop2_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
  tput setaf 3; echo "Squeezelite stopped."
else
  tput setaf 3; echo "Squeezelite installation via package manager failed."
fi

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
tput setaf 3; echo "Compiling latest Squeezelite:"
tput setaf 7; cd /usr/bin/Squeezelite
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/Squeezelite/squeezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
tput setaf 3; echo "Creating symbolic links."
mv /usr/bin/squeezelite /usr/bin/squeezelite.bac
ln -s /usr/bin/Squeezelite/squeezelite/squeezelite /usr/bin/squeezelite

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
tput setaf 3; echo "Started Squeezelite."
exit
