#!/bin/bash

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "SqueezeAudioDIY | Coenraad Human" --menu --scrolltext "Squeezelite default options:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Change Squeezelite player name" \
"2" "option2" \
"3" "option3" \
"4" "option4" \
"5" "option5" \
"6" "option6" \
"7" "option7" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_name.sh
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/options/
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
	echo "[ ERROR ] CANCELED"
	exit
fi
