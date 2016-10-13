#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTIONS
#------------------------------------
audio_select () {
  selected_device=$(sed -n "${device}p" /usr/share/squeeze_files/tmp/devices.txt)
  sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
  sed -i '9s/$/"/' /etc/default/squeezelite
  sed -i '9s/cha/"/' /etc/default/squeezelite
  name_settings=$(cat /etc/default/squeezelite)
  eval `resize` && whiptail --title "$title" --msgbox "$name_settings" $LINES $COLUMNS
}

create_list () {
  squeezelite -l > /usr/share/squeeze_files/tmp/available_list.txt
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES SPACES FROM FILE
  sed -i '1 d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
  sed -i '$ d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES LAST LINE FROM FILE
  sed 's/-.*//' /usr/share/squeeze_files/tmp/available_list.txt > /usr/share/squeeze_files/tmp/devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/squeeze_files/tmp/devices.txt #REMOVES SPACES FROM FILE
}

device_info () {
  if (eval `resize` && whiptail \
          --title "$title" \
          --yesno "Would you like to change your audio device?: \n\n$display_list" \
          $LINES $COLUMNS $(( $LINES - 12 )) \
          --scrolltext )
        then
          device_select
        else
          squeeze_setup
  fi
}

device_select () {
  device=$(eval `resize` && whiptail --title "$title" --inputbox "$available_list" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    service squeezelite stop
    audio_select
    service squeezelite start
    squeeze_setup
  else
    squeeze_setup
  fi
}

#------------------------------------
#REQUIREMENTS
#------------------------------------
create_list
available_list=$(cat -n /usr/share/squeeze_files/tmp/devices.txt)
display_list=$(cat -n /usr/share/squeeze_files/tmp/available_list.txt)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "View audio devices in detail" \
"2" "Change audio device" \
"3" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		device_info
	elif [ $menu = 2 ]; then
		device_select
  elif [ $menu = 3 ]; then
		squeeze_setup
  fi
else
	exit
fi

#------------------------------------
#CLEANUP
#------------------------------------
rm /usr/share/squeeze_files/tmp/available_list.txt
rm /usr/share/squeeze_files/tmp/devices.txt
