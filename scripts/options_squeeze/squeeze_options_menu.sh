#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

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
"3" "Set extra arguments to Squeezelite" \
"4" "Deactivate extra arguments" \
"5" "Point Squeezelite to your Server via IPv4" \
"6" "Deactivate custom server IPv4 address" \
"7" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		view_settings
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_options_menu.sh
	elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_name.sh
	elif [ $menu = 3 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_extra_args.sh
	elif [ $menu = 4 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/queeze_args_de.sh
	elif [ $menu = 5 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_server.sh
	elif [ $menu = 6 ]; then
		/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_server_de.sh
	elif [ $menu = 7 ]; then
		sadiy_setup
  fi
else
	exit
fi
