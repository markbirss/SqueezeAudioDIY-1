#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS --scrolltext
}

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "View current settings" \
"2" "Set Squeezelite player name" \
"3" "Deactivate player name" \
"4" "Set extra arguments to Squeezelite" \
"5" "Deactivate extra arguments" \
"6" "Point Squeezelite to your Server via IPv4" \
"7" "Deactivate custom server IPv4 address" \
"8" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		view_settings
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/options/name/squeeze_name.sh
	elif [ $menu = 3 ]; then
		/usr/share/squeeze_files/setup/scripts/options/name/squeeze_name_de.sh
	elif [ $menu = 4 ]; then
		/usr/share/squeeze_files/setup/scripts/options/arguments/squeeze_extra_args.sh
	elif [ $menu = 5 ]; then
		/usr/share/squeeze_files/setup/scripts/options/arguments/squeeze_args_de.sh
	elif [ $menu = 6 ]; then
		/usr/share/squeeze_files/setup/scripts/options/server/squeeze_server.sh
	elif [ $menu = 7 ]; then
		/usr/share/squeeze_files/setup/scripts/options/server/squeeze_server_de.sh
	elif [ $menu = 8 ]; then
		squeeze_setup
  fi
else
	exit
fi
