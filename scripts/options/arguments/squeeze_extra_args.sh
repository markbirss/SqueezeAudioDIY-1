#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

args_changer () {
	sed -i '19s:.*:SB_EXTRA_ARGS=cha'$1' -d all=debug -f /var/log/squeezeaudiodiy/squeezelite.log:' /etc/default/squeezelite
	sed -i '19s:$:":' /etc/default/squeezelite
	sed -i '19s:cha:":' /etc/default/squeezelite
	sed -i '19s:+:\ :g' /etc/default/squeezelite 
}

argumentsfile=$(cat /usr/share/squeeze_files/setup/files/squeeze_argumentsfile.txt)
inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "$argumentsfile" $LINES $COLUMNS ? --scrolltext 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
	service squeezelite start
	args_changer $inputbox
	view_settings
	service squeezelite start
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
else
	/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
fi
