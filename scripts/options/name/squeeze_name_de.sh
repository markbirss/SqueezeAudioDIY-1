#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
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

name_de
