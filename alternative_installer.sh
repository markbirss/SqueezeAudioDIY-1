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
#DETERMINE PACKAGE MANAGER
#------------------------------------
packagemanager=$(whiptail --title "Squeezelite Setup | ictinus2310" --menu "Choose your package manager:" 20 60 10 \
"1" "Advanced Package Tool - APT" \
"2" "RPM Package Manager - YUM" \
"3" "RPM Package Manager - DNF" \
"4" "Pacman Package Manager" 3>&1 1>&2 2>&3)

#------------------------------------
#INSTALL REQUIRED LIBRARIES & GIT
#------------------------------------
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $packagemanager = 1 ]; then
    tput setaf 3; echo "Installing required libraries."
    tput setaf 7; apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    tput setaf 3; echo "Installed required libraries."
    tput setaf 3; echo "Updating Git"
    tput setaf 7; apt-get install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    tput setaf 3; echo "Git installed."
	elif [ $packagemanager = 2]; then
    tput setaf 3; echo "Installing required libraries."
    tput setaf 7; yum install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    tput setaf 3; echo "Installed required libraries."
    tput setaf 3; echo "Updating Git"
    tput setaf 7; yum install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    tput setaf 3; echo "Git installed."
	elif [ $packagemanager = 3 ]; then
    tput setaf 3; echo "Installing required libraries."
    tput setaf 7; dnf install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    tput setaf 3; echo "Installed required libraries."
    tput setaf 3; echo "Updating Git"
    tput setaf 7; dnf install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    tput setaf 3; echo "Git installed."
	elif [ $packagemanager = 4 ]; then
    tput setaf 3; echo "Installing required libraries."
    tput setaf 7; pacman -S install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    tput setaf 3; echo "Installed required libraries."
    tput setaf 3; echo "Updating Git"
    tput setaf 7; pacman -S install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    tput setaf 3; echo "Git installed."
	fi
else
	echo "You chose cancel."
	exit
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
mkdir /usr/bin/Squeezelite/tools
mkdir /usr/bin/Squeezelite/logs
tput setaf 3; echo "Directories created."

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
tput setaf 3; echo "Installing Squeezelite tools."
cp ./squeeze_* /usr/bin/Squeezelite/tools
chmod +x /usr/bin/Squeezelite/tools/squeeze_setup.sh
tput setaf 3; echo "Squeezelite tools installed."

#------------------------------------
#SYMLINKS FOR SQUEEZE TOOLS
#------------------------------------
rm /usr/bin/squeeze_setup > /usr/bin/Squeezelite/logs/tools_sym_log.txt
ln -s /usr/bin/Squeezelite/tools/squeeze_setup.sh /usr/bin/squeeze_setup
tput setaf 3; echo "Squeezelite tools active."

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
#SQUEEZELITE SETTINGS FILE
#------------------------------------
touch /etc/default/squeezelite

#------------------------------------
#START SQUEEZELITE ON STARTUP
#------------------------------------


#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
tput setaf 3; echo "Started Squeezelite."
exit
