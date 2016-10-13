#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS
}

audio_changer () {
  squeezelite -l > /usr/share/sadiy_files/tmp/available_list.txt
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES SPACES FROM FILE
  sed -i '1 d' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
  sed -i '$ d' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES LAST LINE FROM FILE
  sed 's/-.*//' /usr/share/sadiy_files/tmp/available_list.txt > /usr/share/sadiy_files/tmp/devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/sadiy_files/tmp/devices.txt #REMOVES SPACES FROM FILE
  available_list=$(cat -n /usr/share/sadiy_files/tmp/devices.txt)
  display_list=$(cat -n /usr/share/sadiy_files/tmp/available_list.txt)
  device=$(eval `resize` && whiptail --title "$title" --inputbox "$available_list" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    selected_device=$(sed -n "${device}p" /usr/share/sadiy_files/tmp/devices.txt)
    sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
    sed -i '9s/$/"/' /etc/default/squeezelite
    sed -i '9s/cha/"/' /etc/default/squeezelite
  fi
  rm /usr/share/sadiy_files/tmp/available_list.txt
  rm /usr/share/sadiy_files/tmp/devices.txt
}

name_changer () {
  inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "Please enter new name:" $LINES $COLUMNS New_Name 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    sed -i '6s:.*:SL_NAME=cha'$inputbox':' /etc/default/squeezelite
  	sed -i '6s:$:":' /etc/default/squeezelite
  	sed -i '6s:cha:":' /etc/default/squeezelite
  fi
}

#------------------------------------
#PROCESS
#------------------------------------
service squeezelite stop
name_changer
audio_changer
view_settings
service squeezelite start
exit
