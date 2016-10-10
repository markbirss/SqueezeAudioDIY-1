#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

server_de () {
	service squeezelite stop
	sed -i 15s/.*/#SB_SERVER_IP=cha/ /etc/default/squeezelite
	sed -i '15s/$/"/' /etc/default/squeezelite
	sed -i '15s/cha/"/' /etc/default/squeezelite
	service squeezelite start
	view_settings
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
}

name_de () {
	service squeezelite stop
	sed -i 6s/.*/#SL_NAME=cha/ /etc/default/squeezelite
	sed -i '6s/$/"/' /etc/default/squeezelite
	sed -i '6s/cha/"/' /etc/default/squeezelite
	service squeezelite start
	view_settings
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
}

args_de () {
	service squeezelite stop
	sed -i 19s/.*/#SB_EXTRA_ARGS=cha/ /etc/default/squeezelite
	sed -i '19s/$/"/' /etc/default/squeezelite
	sed -i '19s/cha/"/' /etc/default/squeezelite
	service squeezelite start
	view_settings
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
}

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
		/usr/share/squeeze_files/setup/scripts/options/squeeze_name.sh
	elif [ $menu = 2 ]; then
		name_de
	elif [ $menu = 3 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_extra_args.sh
	elif [ $menu = 4 ]; then
		args_de
	elif [ $menu = 5 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_server.sh
	elif [ $menu = 6 ]; then
		server_de
	elif [ $menu = 7 ]; then
		squeeze_setup
  fi
else
	exit
fi
