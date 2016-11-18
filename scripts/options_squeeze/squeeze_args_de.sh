#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

args_de () {
	service squeezelite stop
	sed -i '19s:.*:SB_EXTRA_ARGS=cha-d all=debug -f /tmp/squeezelite.log:' /etc/default/squeezelite
	sed -i '19s:$:":' /etc/default/squeezelite
	sed -i '19s:cha:":' /etc/default/squeezelite
	service squeezelite start
	view_settings
	/usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_options_menu.sh
}

args_de
