#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Main Menu:" 18 60 10 \
"1" "LMS Installers" \
"2" "Squeezelite Installers" \
"3" "Squeezelite Options" \
"4" "Logs" \
"5" "Update SqueezeAudioDIY" \
"6" "Uninstall Software" \
"7" "Exit" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/linux/lms_install.sh
  elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/linux/squeeze_install.sh
	elif [ $menu = 3 ]; then
		/usr/share/sadiy_files/setup/scripts/linux/squeeze_options.sh
  elif [ $menu = 4 ]; then
  	/usr/share/sadiy_files/setup/scripts/linux/sadiy_logs.sh
  elif [ $menu = 5 ]; then
    /usr/share/sadiy_files/setup/scripts/linux/sadiy_update.sh
  elif [ $menu = 6 ]; then
		/usr/share/sadiy_files/setup/scripts/linux/sadiy_uninstaller.sh
  elif [ $menu = 7 ]; then
		exit
  fi
else
	exit
fi
