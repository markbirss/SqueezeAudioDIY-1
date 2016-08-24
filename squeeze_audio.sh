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
service squeezelite stop
echo "Stopped Squeezelite."

#------------------------------------
#AUDIO DEVICES AVAILABLE
#------------------------------------
squeezelite -l > ./available_list.txt

#------------------------------------
#CREATE AVAILABLE LIST
#------------------------------------
sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' ./available_list.txt #REMOVES SPACES FROM FILE
sed -i '1 d' ./available_list.txt #REMOVES FIRST LINE FROM FILE
sed -i '$ d' ./available_list.txt #REMOVES LAST LINE FROM FILE

#------------------------------------
#DISPLAY AVAILABLE LIST
#------------------------------------
echo "###################################################################"
echo "   SELECT DEVICE BY ENTERING CORRESPONDING NUMBER NEXT TO DEVICE   "
echo "###################################################################"
cat -n ./available_list.txt #LIST LINES WITH LINE NUMBERS

#------------------------------------
#CREATE DEVICE LIST
#------------------------------------
sed 's/-.*//' ./available_list.txt > ./devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' ./devices.txt #REMOVES SPACES FROM FILE

#------------------------------------
#SELECT DEVICE
#------------------------------------
echo -n "SELECTED DEVICE: "
read device
selected_device=$(sed -n "${device}p" ./devices.txt)

#------------------------------------
#EDIT SQUEEZELITE CONFIG FILE
#------------------------------------
sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
sed -i '9s/$/"/' /etc/default/squeezelite
sed -i '9s/cha/"/' /etc/default/squeezelite

#------------------------------------
#VIEW NEW SETTINGS
#------------------------------------
echo "###################################################################"
echo "                           NEW SETTINGS                            "
echo "###################################################################"
cat /etc/default/squeezelite

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."

#------------------------------------
#TEMP FILES CLEANUP
#------------------------------------
rm ./available_list.txt 
rm ./devices.txt
exit
