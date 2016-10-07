#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#AUDIO DEVICES AVAILABLE
#------------------------------------
squeezelite -l > /usr/share/squeeze_files/tmp/available_list.txt

#------------------------------------
#CREATE AVAILABLE LIST
#------------------------------------
sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES SPACES FROM FILE
sed -i '1 d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
sed -i '$ d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES LAST LINE FROM FILE

#------------------------------------
#CREATE DEVICE LIST
#------------------------------------
sed 's/-.*//' /usr/share/squeeze_files/tmp/available_list.txt > /usr/share/squeeze_files/tmp/devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/squeeze_files/tmp/devices.txt #REMOVES SPACES FROM FILE

#------------------------------------
#SELECT DEVICE
#------------------------------------
available_list=$(cat -n /usr/share/squeeze_files/tmp/devices.txt)
device=$(eval `resize` && whiptail --title "SqueezeAudioDIY 1.2.1 | Coenraad Human" --inputbox "$available_list" $LINES $COLUMNS Number 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "You chose:" $device > /dev/null 2>&1
else
    squeeze_setup
fi

#------------------------------------
#EDIT SQUEEZELITE CONFIG FILE
#------------------------------------
selected_device=$(sed -n "${device}p" /usr/share/squeeze_files/tmp/devices.txt)
sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
sed -i '9s/$/"/' /etc/default/squeezelite
sed -i '9s/cha/"/' /etc/default/squeezelite

#------------------------------------
#VIEW NEW SETTINGS
#------------------------------------
name_settings=$(cat /etc/default/squeezelite)
eval `resize` && whiptail --title "SqueezeAudioDIY 1.2.1 | Coenraad Human" --msgbox "$name_settings" $LINES $COLUMNS

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start

#------------------------------------
#TEMP FILES CLEANUP
#------------------------------------
rm /usr/share/squeeze_files/tmp/available_list.txt
rm /usr/share/squeeze_files/tmp/devices.txt
squeeze_setup
