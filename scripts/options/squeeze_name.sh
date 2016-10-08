#!/bin/bash
title=$(SqueezeAudioDIY 1.3 | Coenraad Human)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

name_changer () {
	sed -i 6s/.*/SL_NAME=cha$1/ /etc/default/squeezelite
	sed -i '6s/$/"/' /etc/default/squeezelite
	sed -i '6s/cha/"/' /etc/default/squeezelite
}

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
sudo service squeezelite stop

#------------------------------------
#BACKUP SQUEEZELITE CONFIG FILE
#------------------------------------
bacname=$(date +"%Y%m%d.%H%M%S")
cp /etc/default/squeezelite /usr/share/squeeze_files/settings/backups/bacname

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "squeeze_audio" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Change name to localhost name" \
"2" "Enter own custom name" \
"3" "Show current settings" \
"4" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		name_changer $(hostname -s)
		view_settings
		service squeezelite start
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
	elif [ $menu = 2 ]; then
		new_name=$(eval `resize` && whiptail --title "$title" --inputbox "Please enter new name:" $LINES $COLUMNS New_Name 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			name_changer $new_name
			view_settings
			service squeezelite start
			/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
		else
			/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
		fi
	elif [ $menu = 3 ]; then
		view_settings
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
	elif [ $menu = 4 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
	fi
else
	exit
fi
