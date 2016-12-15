#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

squeeze_install_latest () {
#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop
#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get update
apt-get install -y wget xterm unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential
#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get install -y squeezelite
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
service squeezelite stop
#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
rm -R /usr/share/sadiy_files/installers/squeeze_latest
mkdir /usr/share/sadiy_files/installers/squeeze_latest
cd /usr/share/sadiy_files/installers/squeeze_latest
apt-get install -y git
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/share/sadiy_files/installers/squeeze_latest/squeezelite/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite
cp ./squeezelite /usr/bin/
#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
#------------------------------------
#GO BACK TO MENU
#------------------------------------
sadiy_setup
}
squeeze_reinstall () {
#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop
#------------------------------------
#INSTALL REQUIRED LIBRARIES
#------------------------------------
apt-get update
apt-get install -y wget xterm unzip ffmpeg libsoxr-dev libasound2-dev libflac-dev libmad0-dev libvorbis-dev libfaad-dev libmpg123-dev liblircclient-dev libncurses5-dev build-essential
#------------------------------------
#INSTALL SQUEEZELITE
#------------------------------------
apt-get install -y squeezelite
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
service squeezelite stop
#------------------------------------
#COMPILE SQUEEZELITE
#------------------------------------
rm -R /usr/share/sadiy_files/installers/squeeze_include
mkdir /usr/share/sadiy_files/installers/squeeze_include
unzip /usr/share/sadiy_files/setup/files/squeezelite-v1.8.5-802.zip -d /usr/share/sadiy_files/installers/squeeze_include
cd /usr/share/sadiy_files/installers/squeeze_include/squeezelite-master/
OPTS="-DDSD -DRESAMPLE -DALSA" make
rm /usr/bin/squeezelite
cp ./squeezelite /usr/bin/
#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
#------------------------------------
#GO BACK TO MENU
#------------------------------------
sadiy_setup
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Install menu:" 18 60 10 \
"1" "Re-install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		squeeze_reinstall 2>&1 | tee /var/log/squeezeaudiodiy/sque_re-install.log_$logname
	elif [ $menu = 2 ]; then
		squeeze_install_latest 2>&1 | tee /var/log/squeezeaudiodiy/squeeze_latest_.log_$logname
	elif [ $menu = 3 ]; then
  	sadiy_setup
	fi
else
	exit
fi
