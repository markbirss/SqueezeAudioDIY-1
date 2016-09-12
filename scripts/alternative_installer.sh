#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /usr/bin/Squeezelite/logs/squeeze_stop1_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
  echo "---Squeezelite stopped---"
else
  echo "---No previous version of Squeezelite---"
fi

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/Squeezelite
directoryquery=$($?)
if [ directoryquery = 0 ]
then
  echo "---Old files removed---"
else
  echo "---No previous installation found---"
fi
#MAKING NEW DIRECTORIES
mkdir /usr/bin/Squeezelite
mkdir /usr/bin/Squeezelite/setup
mkdir /usr/bin/Squeezelite/logs
echo "---Directories created---"

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
    echo "---Installing required libraries---"
    apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
    fi
    echo "---Updating Git---"
    apt-get install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    echo "---Git installed---"
	elif [ $packagemanager = 2 ]; then
    echo "---Installing required libraries---"
    yum install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
    fi
    echo "---Updating Git---"
    yum install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    echo "---Git installed---"
	elif [ $packagemanager = 3 ]; then
    echo "---Installing required libraries---"
    dnf install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
    fi
    echo "---Updating Git---"
    dnf install git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    echo "---Git installed---"
	elif [ $packagemanager = 4 ]; then
    echo "---Installing required libraries---"
    pacman -S libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
    if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
    fi
    echo "---Updating Git---"
    pacman -S git 2>&1 | tee /usr/bin/Squeezelite/logs/git_log.txt #LOG SYSTEM
    echo "---Git installed---"
	fi
else
	echo "---You chose cancel---"
	exit
fi

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
echo "---Installing Squeezelite tools---"
cp -R ./* /usr/bin/Squeezelite/setup
chmod +x /usr/bin/Squeezelite/setup/setup.sh
echo "---Squeezelite tools installed---"

#------------------------------------
#SYMLINKS FOR SQUEEZE TOOLS
#------------------------------------
rm /usr/bin/squeeze_setup > /usr/bin/Squeezelite/logs/tools_sym_log.txt
ln -s /usr/bin/Squeezelite/setup/setup.sh /usr/bin/squeeze_setup
echo "---Squeezelite tools active---"

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
echo "---Compiling latest Squeezelite---"
cd /usr/bin/Squeezelite
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/Squeezelite/squeezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
echo "---Creating symbolic links---"
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
echo "---Started Squeezelite---"
exit
