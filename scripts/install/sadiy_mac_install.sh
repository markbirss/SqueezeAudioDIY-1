#!/bin/bash

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /var/log/squeezeaudiodiy > /dev/null 2>&1
rm -R /Applications/sadiy_files > /dev/null 2>&1
rm -R /Applications/sadiy_files > /dev/null 2>&1
#MAKING NEW DIRECTORIES
mkdir /Applications/sadiy_files
#LOG DIRECTORY
mkdir /var/log/squeezeaudiodiy
#OTHER DIRECTORY
mkdir /Applications/sadiy_files/other
echo "[ OK ] DIRECTORIES CREATED"

#------------------------------------
#SQUEEZE TOOLS
#------------------------------------
cp -R ./* /Applications/sadiy_files
rm /usr/bin/sadiy_setup > /dev/null 2>&1
ln -s /Applications/sadiy_files/scripts/mac/sadiy_setup.sh /usr/bin/sadiy_setup
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] SQUEEZELITE TOOLS INSTALLED"
  else
    echo "[ ERROR ] SQUEEZELITE TOOLS INSTALL FAILED"
fi

#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
mkdir ./tmp
cd ./tmp
tar -zxvf ../files/squeezelite-v1.8.5-809-mac.tar.gz
architecture=$(uname -m)
if [ $architecture = x86_64 ]; then
    cp ./squeezelite/bin/squeezelite-x86_64 /usr/bin
  elif [ $architecture = i386 ]; then
    cp ./squeezelite/bin/squeezelite-i386 /usr/bin
fi

#------------------------------------
#START SQUEEZELITE
#------------------------------------
squeezelite-x86_64 -d all=debug -f /tmp/squeezeaudiodiy/squeezelite.log &

#------------------------------------
#FIRST CONFIG RUN
#------------------------------------
name_changer
audio_changer
view_settings
exit
