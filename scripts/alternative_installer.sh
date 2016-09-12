#!/bin/bash

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/squeeze_files
directoryquery=$($?)
if [ directoryquery = 0 ]
then
  echo "---Old files removed---"
else
  echo "---No previous installation found---"
fi
#MAKING NEW DIRECTORIES
mkdir /usr/bin/squeeze_files
mkdir /usr/bin/squeeze_files/setup
mkdir /usr/bin/squeeze_files/logs
echo "---Directories created---"

#------------------------------------
#DETERMINE PACKAGE MANAGER
#------------------------------------
packagemanager=$(whiptail --title "Squeezelite Setup | ictinus2310" --menu "Choose your package manager:" 20 60 10 \
"1" "Advanced Package Tool - APT" \
"2" "RPM Package Manager - YUM" \
"3" "RPM Package Manager - DNF" \
"4" "Pacman Package Manager" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[OK] Menu"
else
	echo "---You chose cancel---"
	exit
fi

#------------------------------------
#INSTALL REQUIRED LIBRARIES & GIT
#------------------------------------
if [ $packagemanager = 1 ]; then
  echo "---Installing required libraries---"
  apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  if [ $exitstatus = 0 ]
  then
    echo "---Installed required libraries---"
  else
    echo "[ERROR] Libraries install failed."
  fi
  echo "---Updating Git---"
  apt-get install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  echo "---Git installed---"
	elif [ $packagemanager = 2 ]; then
  echo "---Installing required libraries---"
  yum install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  if [ $exitstatus = 0 ]
  then
    echo "---Installed required libraries---"
  else
    echo "[ERROR] Libraries install failed."
  fi
  echo "---Updating Git---"
  yum install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  echo "---Git installed---"
  elif [ $packagemanager = 3 ]; then
  echo "---Installing required libraries---"
  dnf install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
  fi
  echo "---Updating Git---"
  dnf install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  echo "---Git installed---"
	elif [ $packagemanager = 4 ]; then
  echo "---Installing required libraries---"
  pacman -S libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  if [ $exitstatus = 0 ]
    then
      echo "---Installed required libraries---"
    else
      echo "[ERROR] Libraries install failed."
  fi
  echo "---Updating Git---"
  pacman -S git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  echo "---Git installed---"
fi

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
echo "---Installing Squeezelite tools---"
cp -R ./* /usr/bin/squeeze_files/setup
chmod +x /usr/bin/squeeze_files/setup/setup.sh
echo "---Squeezelite tools installed---"

#------------------------------------
#SYMLINKS FOR SQUEEZE TOOLS
#------------------------------------
rm /usr/bin/squeeze_setup > /usr/bin/squeeze_files/logs/tools_sym_log.txt
ln -s /usr/bin/squeeze_files/setup/setup.sh /usr/bin/squeeze_setup
echo "---Squeezelite tools active---"

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
echo "---Compiling latest Squeezelite---"
cd /usr/bin/squeeze_files/
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/squeeze_files/squeezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
echo "---Creating symbolic links---"
rm /usr/bin/squeezelite
ln -s /usr/bin/squeeze_files/squeezelite/squeezelite /usr/bin/squeezelite

#------------------------------------
#SQUEEZELITE SETTINGS FILE
#------------------------------------
touch /etc/default/squeezelite

#------------------------------------
#START SQUEEZELITE ON STARTUP
#------------------------------------
