#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
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
		/usr/share/sadiy_files/setup/scripts/options/squeeze_options_menu.sh
  elif [ $menu = 3 ]; then
  	/usr/share/sadiy_files/setup/scripts/option2/
  elif [ $menu = 4 ]; then
  	/usr/share/sadiy_files/setup/scripts/
  elif [ $menu = 5 ]; then
    /usr/share/sadiy_files/setup/scripts/
  elif [ $menu = 6 ]; then
		/usr/share/sadiy_files/setup/scripts/
  fi
else
	exit
fi
