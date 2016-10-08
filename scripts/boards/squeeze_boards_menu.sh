#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Orange Pi" \
"2" "Raspberry Pi" \
"3" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/boards/squeeze_boards_opi.sh
	elif [ $menu = 2 ]; then
    /usr/share/squeeze_files/setup/scripts/boards/squeeze_boards_rpi.sh
	elif [ $menu = 3 ]; then
		squeeze_setup
  fi
else
	exit
fi
