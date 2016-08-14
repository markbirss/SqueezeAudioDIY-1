#!/bin/bash

#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
	tput setaf 3; echo "Running as root."
else
        tput setaf 3; echo "Run script as root."
        exit
fi
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
echo "#####################################"
echo " NAME CHANGER FOR SQUEEZELITE PLAYER "
echo "#####################################"
echo " 1 Change name to localhost name"
echo " 2 Enter own custom name"
echo " 3 Restore previous settings"
echo "#####################################"
echo -n "ENTERED: "
read user_input

#------------------------------------
#USER INPUT
#------------------------------------
if [ $user_input = 1 ]
then
	sed -i 6s/.*/SL_NAME=cha$(hostname -s)/ /etc/default/squeezelite
	sed -i '6s/$/"/' /etc/default/squeezelite
	sed -i '6s/cha/"/' /etc/default/squeezelite
fi

if [ $user_input = 2 ]
then
	echo -n "NEW NAME (DON'T USE SPACES): "
	read new_name
	sed -i 6s/.*/SL_NAME=cha$new_name/ /etc/default/squeezelite
        sed -i '6s/$/"/' /etc/default/squeezelite
        sed -i '6s/cha/"/' /etc/default/squeezelite
fi

if [ $user_input = 3 ]
then
	mv /etc/default/squeezelite.2.namebac /etc/default/squeezelite
fi
#------------------------------------
#NEW SETTINGS
#------------------------------------
echo "#####################################"
echo "             NEW SETTINGS            "
echo "#####################################"
cat /etc/default/squeezelite
echo "#####################################"

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
