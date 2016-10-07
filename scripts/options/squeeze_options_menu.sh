#!/bin/bash

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "SqueezeAudioDIY 1.2.1 | Coenraad Human" --menu "Squeezelite default options:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Set Squeezelite player name" \
"2" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_name.sh
	elif [ $menu = 2 ]; then
		squeeze_setup
  elif [ $menu = 3 ]; then
  	/usr/share/squeeze_files/setup/scripts/options/
  elif [ $menu = 4 ]; then
  	/usr/share/squeeze_files/setup/scripts/options/
  elif [ $menu = 5 ]; then
    /usr/share/squeeze_files/setup/scripts/options/
	elif [ $menu = 6 ]; then
		/usr/share/squeeze_files/setup/scripts/options/
  elif [ $menu = 7 ]; then
		/usr/share/squeeze_files/setup/scripts/options/
  fi
else
	echo "[ ERROR ] CANCELED" > /dev/null 2>&1
	exit
fi
