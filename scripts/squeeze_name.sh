#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
sudo service squeezelite stop

#------------------------------------
#BACKUP SQUEEZELITE CONFIG FILE
#------------------------------------
mv /etc/default/squeezelite.1.namebac /etc/default/squeezelite.2.namebac
cp /etc/default/squeezelite /etc/default/squeezelite.1.namebac
echo "[ OK ] BACKUP MADE OF SETTINGS"

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "Squeezelite Setup | Coenraad Human" --menu "squeeze_audio" 20 60 10 \
"1" "Change name to localhost name" \
"2" "Enter own custom name" \
"3" "Show current settings" 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		sed -i 6s/.*/SL_NAME=cha$(hostname -s)/ /etc/default/squeezelite
		sed -i '6s/$/"/' /etc/default/squeezelite
		sed -i '6s/cha/"/' /etc/default/squeezelite
	elif [ $menu = 2 ]; then
		new_name=$(whiptail --title "squeeze_name" --inputbox "Please enter new name:" 10 60 New_Name 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			sed -i 6s/.*/SL_NAME=cha$new_name/ /etc/default/squeezelite
    	sed -i '6s/$/"/' /etc/default/squeezelite
    	sed -i '6s/cha/"/' /etc/default/squeezelite
		else
			echo "[ ERROR ] CANCELED"
			exit
		fi
	elif [ $menu = 3 ]; then
		name_settings=$(cat /etc/default/squeezelite)
		whiptail --title "Current Settings" --msgbox "$name_settings" 30 99
	fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi

#------------------------------------
#NEW SETTINGS
#------------------------------------
name_settings=$(cat /etc/default/squeezelite)
whiptail --title "Current Settings" --msgbox "$name_settings" 30 99

#------------------------------------
#BACKUP SQUEEZELITE CONFIG FILE
#------------------------------------
cp /etc/default/squeezelite /etc/default/squeezelite.1.namebac
echo "[ OK ] BACKUP MADE OF SETTINGS"

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "[ OK ] SQUEEZELITE STARTED"
exit
