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
	sed -i 19s/.*/SB_EXTRA_ARGS=cha$1/ /etc/default/squeezelite
	sed -i '19s/$/"/' /etc/default/squeezelite
	sed -i '19s/cha/"/' /etc/default/squeezelite
}

inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "Please enter arguments:" $LINES $COLUMNS New_Name 3>&1 1>&2 2>&3)
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
