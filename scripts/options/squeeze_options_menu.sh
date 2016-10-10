#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Set Squeezelite player name" \
"2" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_name.sh
	elif [ $menu = 2 ]; then
		squeeze_setup
  fi
else
	exit
fi
