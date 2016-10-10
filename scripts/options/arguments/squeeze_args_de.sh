#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

args_de () {
	service squeezelite stop
	sed -i 19s/.*/"SB_EXTRA_ARGS=cha-f /usr/share/squeeze_files/logs/squeeze/log.txt"/ /etc/default/squeezelite
	sed -i '19s/$/"/' /etc/default/squeezelite
	sed -i '19s/cha/"/' /etc/default/squeezelite
	service squeezelite start
	view_settings
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
}

args_de
