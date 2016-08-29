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
echo "Backup of current settings made."

#------------------------------------
#MENU
#------------------------------------
OPTION=$(whiptail --title "ictinus2310 Squeezelite Setup" --menu "squeeze_audio" 20 60 10 \
"1" "Change name to localhost name" \
"2" "Enter own custom name" \
"3" "Restore previous settings" \
"4" "Show current settings" 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]
then
	if [ $OPTION = 1 ]; then
		sed -i 6s/.*/SL_NAME=cha$(hostname -s)/ /etc/default/squeezelite
		sed -i '6s/$/"/' /etc/default/squeezelite
		sed -i '6s/cha/"/' /etc/default/squeezelite
	elif [ $OPTION = 2 ]; then
		new_name=$(whiptail --title "squeeze_name" --inputbox "Please enter new name:" 10 60 New_Name 3>&1 1>&2 2>&3)
		exitstatus=$?
		if [ $exitstatus = 0 ]; then
			sed -i 6s/.*/SL_NAME=cha$new_name/ /etc/default/squeezelite
    	sed -i '6s/$/"/' /etc/default/squeezelite
    	sed -i '6s/cha/"/' /etc/default/squeezelite
		else
			echo "You chose cancel"
			exit
		fi
	elif [ $OPTION = 3 ]; then
		mv /etc/default/squeezelite.2.namebac /etc/default/squeezelite
	elif [ $OPTION = 4 ]; then
		name_settings=$(cat /etc/default/squeezelite)
		whiptail --title "Current Settings" --msgbox "$name_settings" 30 99
	fi
else
	echo "You chose cancel."
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
cp /etc/default/squeezelite /etc/default/squeezelite.namebac
echo "Backup of settings made."

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."
exit
