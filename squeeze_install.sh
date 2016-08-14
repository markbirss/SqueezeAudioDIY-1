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
service squeezelite stop > /Squeezelite/logs/squeeze_stop1_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
  echo "Squeezelite stopped."
else
  echo "No previous version of Squeezelite."
fi

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /Squeezelite
if [ $? = 0 ]
then
  echo "Old files removed."
else
  echo "No previous installation found."
fi
#MAKING NEW DIRECTORIES
mkdir /Squeezelite
mkdir /Squeezelite/tools
mkdir /Squeezelite/logs
echo "Directories created."

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
echo "Installing Squeezelite tools."
cp ./squeeze_audio.sh /Squeezelite/tools
chmod +x /Squeezelite/tools/squeeze_audio.sh
cp ./squeeze_name.sh /Squeezelite/tools
chmod +x /Squeezelite/tools/squeeze_name.sh
cp ./squeeze_update.sh /Squeezelite/tools
chmod +x /Squeezelite/tools/squeeze_update.sh
echo "Squeezelite tools installed."

#------------------------------------
#SYMLINKS FOR SQUEEZE TOOLS
#------------------------------------
ln -s /Squeezelite/tools/squeeze_audio.sh /usr/bin/squeeze_audio
ln -s /Squeezelite/tools/squeeze_name.sh /usr/bin/squeeze_name
ln -s /Squeezelite/tools/squeeze_update.sh /usr/bin/squeeze_update
echo "Squeezelite tools active."

#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
echo "Installing required libraries."
apt-get install libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential 2>&1 | tee /Squeezelite/logs/library_log.txt
echo "Installed required libraries."

#------------------------------------
#GIT
#------------------------------------
echo "Updating Git"
apt-get install git > /Squeezelite/logs/git_log.txt #LOG SYSTEM
echo "Done updating Git."

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
echo "Installing Squeezelite using package manager."
apt-get install squeezelite > /Squeezelite/logs/apt_squeeze_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
        echo "Installed Squeezelite using package manager."
else
        echo "Package manager does not have Squeezelite"
        echo "-----------------------------------------"
        echo "     Squeezelite will not auto start     "
        echo "     and will not have config files.     "
        echo "-----------------------------------------"
fi

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop > /Squeezelite/logs/squeeze_stop2_log.txt #LOG SYSTEM
if [ $? = 0 ]
then
  echo "Squeezelite stopped."
else
  echo "Squeezelite installation via package manager failed."
fi

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
mv /usr/bin/squeezelite /usr/bin/squeezelite.bac
ln -s /Squeezelite/squeezelite/squeezelite /usr/bin/squeezelite

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."
exit
