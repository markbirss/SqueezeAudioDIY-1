#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Set Squeezelite player name" \
"2" "Deactivate player name" \
"3" "Set extra arguments to Squeezelite" \
"4" "Deactivate extra arguments" \
"5" "Point Squeezelite to your Server via IPv4" \
"6" "Deactivate custom server IPv4 address" \
"7" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/options/name/squeeze_name.sh
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/options/name/squeeze_name_de.sh
	elif [ $menu = 3 ]; then
		/usr/share/squeeze_files/setup/scripts/options/arguments/squeeze_extra_args.sh
	elif [ $menu = 4 ]; then
		/usr/share/squeeze_files/setup/scripts/options/arguments/squeeze_args_de.sh
	elif [ $menu = 5 ]; then
		/usr/share/squeeze_files/setup/scripts/options/server/squeeze_server.sh
	elif [ $menu = 6 ]; then
		/usr/share/squeeze_files/setup/scripts/options/server/squeeze_server_de.sh
	elif [ $menu = 7 ]; then
		squeeze_setup
  fi
else
	exit
fi
