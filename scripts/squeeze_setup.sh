#!/bin/bash

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "Squeezelite Setup | Coenraad Human " --menu "Main Menu:" 20 60 10 \
"1" "Install Squeezelite" \
"2" "Update Squeezelite" \
"3" "Change default audio device" \
"4" "Change name of player" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		chmod +x /usr/share/squeeze_files/setup/scripts/squeeze_install.sh
		/usr/share/squeeze_files/setup/scripts/squeeze_install.sh
	elif [ $menu = 2]; then
		chmod +x /usr/share/squeeze_files/setup/scripts/squeeze_update.sh
		/usr/share/squeeze_files/setup/scripts/squeeze_update.sh
	elif [ $menu = 3 ]; then
		chmod +x /usr/share/squeeze_files/setup/scripts/squeeze_audio.sh
		/usr/share/squeeze_files/setup/scripts/squeeze_audio.sh
	elif [ $menu = 4 ]; then
		chmod +x /usr/share/squeeze_files/scripts/squeeze_name.sh
		/usr/share/squeeze_files/setup/scripts/squeeze_name.sh
	fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
