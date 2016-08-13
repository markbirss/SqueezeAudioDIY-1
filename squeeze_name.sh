#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
sudo service squeezelite stop

#------------------------------------
#BACKUP SQUEEZELITE CONFIG FILE
#------------------------------------
sudo mv /etc/default/squeezelite.1.namebac /etc/default/squeezelite.2.namebac
sudo cp /etc/default/squeezelite /etc/default/squeezelite.1.namebac
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
	sudo sed -i 6s/.*/SL_NAME=cha$(hostname -s)/ /etc/default/squeezelite
	sudo sed -i '6s/$/"/' /etc/default/squeezelite
	sudo sed -i '6s/cha/"/' /etc/default/squeezelite
fi

if [ $user_input = 2 ]
then
	echo -n "NEW NAME (DON'T USE SPACES): "
	read new_name
	sudo sed -i 6s/.*/SL_NAME=cha$new_name/ /etc/default/squeezelite
        sudo sed -i '6s/$/"/' /etc/default/squeezelite
        sudo sed -i '6s/cha/"/' /etc/default/squeezelite
fi

if [ $user_input = 3 ]
then
	sudo mv /etc/default/squeezelite.2.namebac /etc/default/squeezelite
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
sudo cp /etc/default/squeezelite /etc/default/squeezelite.namebac
echo "Backup of settings made."

#------------------------------------
#START SQUEEZELITE
#------------------------------------
sudo service squeezelite start
echo "Started Squeezelite."
exit
