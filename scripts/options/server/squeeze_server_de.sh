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

server_de
