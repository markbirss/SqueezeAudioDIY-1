#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Installer logs" \
"2" "Squeezelite static log" \
"3" "Squeezelite watch log (ideal when listening)" \
"4" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/logs/logs_installers.sh
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/logs/logs_static_squeeze.sh
  elif [ $menu = 3 ]; then
  	/usr/share/squeeze_files/setup/scripts/logs/logs_watch_squeeze.sh
  elif [ $menu = 4 ]; then
  	squeeze_setup
  fi
else
	exit
fi
