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
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" 18 60 10 \
"1" "Installers" \
"2" "Squeezelite options" \
"3" "Logitech Media Server options" \
"4" "Logs" \
"5" "Update SqueezeAudioDIY" \
"6" "Uninstall software" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/install/install_menu.sh
	elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_options_menu.sh
  elif [ $menu = 3 ]; then
  	/usr/share/sadiy_files/setup/scripts/options_lms/lms_options_menu.sh
  elif [ $menu = 4 ]; then
  	/usr/share/sadiy_files/setup/scripts/logs/logs_menu.sh
  elif [ $menu = 5 ]; then
    /usr/share/sadiy_files/setup/scripts/sadiy_update.sh
  elif [ $menu = 6 ]; then
		/usr/share/sadiy_files/setup/scripts/remove/sadiy_remove_menu.sh
  fi
else
	exit
fi
