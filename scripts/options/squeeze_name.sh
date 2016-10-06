#!/bin/bash

#------------------------------------
#NEW SETTINGS
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
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
echo "[ OK ] BACKUP MADE OF SETTINGS"

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "Squeezelite Setup 1.2 | Coenraad Human" --menu "squeeze_audio" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Change name to localhost name" \
"2" "Enter own custom name" \
"3" "Show current settings" \
"4" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		sed -i 6s/.*/SL_NAME=cha$(hostname -s)/ /etc/default/squeezelite
		sed -i '6s/$/"/' /etc/default/squeezelite
		sed -i '6s/cha/"/' /etc/default/squeezelite
		view_settings
	elif [ $menu = 2 ]; then
		new_name=$(eval `resize` && whiptail --title "Squeezelite Setup 1.2 | Coenraad Human" --inputbox "Please enter new name:" $LINES $COLUMNS New_Name 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			sed -i 6s/.*/SL_NAME=cha$new_name/ /etc/default/squeezelite
    	sed -i '6s/$/"/' /etc/default/squeezelite
    	sed -i '6s/cha/"/' /etc/default/squeezelite
			view_settings
		else
			echo "[ ERROR ] CANCELED"
			exit
		fi
	elif [ $menu = 3 ]; then
		view_settings
	elif [ $menu = 4 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
	fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "[ OK ] SQUEEZELITE STARTED"
exit
