#!/bin/bash

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
  echo "[ OK ] MENU"
else
	echo "[ ERROR ] YOU CHOSE CANCEL"
	exit
fi

#------------------------------------
#INSTALL REQUIRED LIBRARIES & GIT
#------------------------------------
if [ $packagemanager = 1 ]; then
  apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  exitstatus=$?
  if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
  else
    echo "[ ERROR ] LIBRARIES INSTALL FAILED"
  fi
  apt-get install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] GIT INSTALLED"
    else
      echo "[ ERROR ] GIT INSTALL FAILED"
  fi
elif [ $packagemanager = 2 ]; then
  yum install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  exitstatus=$?
  if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
  else
    echo "[ ERROR ] LIBRARIES INSTALL FAILED"
  fi
  yum install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] GIT INSTALLED"
    else
      echo "[ ERROR ] GIT INSTALL FAILED"
  fi
elif [ $packagemanager = 3 ]; then
  dnf install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
    else
      echo "[ ERROR ] LIBRARIES INSTALL FAILED"
  fi
  dnf install git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] GIT INSTALLED"
    else
      echo "[ ERROR ] GIT INSTALL FAILED"
  fi
elif [ $packagemanager = 4 ]; then
  pacman -S libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /usr/bin/squeeze_files/logs/library_log.txt
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] INSTALLED REQUIRED LIBRARIES"
    else
      echo "[ ERROR ] LIBRARIES INSTALL FAILED"
  fi
  pacman -S git 2>&1 | tee /usr/bin/squeeze_files/logs/git_log.txt #LOG SYSTEM
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] GIT INSTALLED"
    else
      echo "[ ERROR ] GIT INSTALL FAILED"
  fi
fi

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
cp -R ./* /usr/bin/squeeze_files/setup
chmod +x /usr/bin/squeeze_files/setup/setup.sh
rm /usr/bin/squeeze_setup > /usr/bin/squeeze_files/logs/tools_sym_log.txt
ln -s /usr/bin/squeeze_files/setup/setup.sh /usr/bin/squeeze_setup
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] SQUEEZELITE TOOLS INSTALLED"
  else
    echo "[ ERROR ] SQUEEZELITE TOOLS INSTALL FAILED"
fi

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
cd /usr/bin/squeeze_files/
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/squeeze_files/squeezelite
OPTS="-DDSD -DRESAMPLER" make
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LATEST SQUEEZELITE COMPILED"
  else
    echo "[ ERROR ] LATEST SQUEEZELITE COMPILING FAILED"
fi

#------------------------------------
#SYMLINKS FOR SQUEEZELITE
#------------------------------------
rm /usr/bin/squeezelite
ln -s /usr/bin/squeeze_files/squeezelite/squeezelite /usr/bin/squeezelite
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] SYMBOLIC LINKS CREATED"
  else
    echo "[ ERROR ] CREATING OF SYMBOLIC FAILED"
fi

#------------------------------------
#SQUEEZELITE SETTINGS FILE
#------------------------------------
touch /etc/default/squeezelite

#------------------------------------
#START SQUEEZELITE ON STARTUP
#------------------------------------
