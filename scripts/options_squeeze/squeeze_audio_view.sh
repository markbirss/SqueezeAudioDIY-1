#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTIONS
#------------------------------------
audio_select () {
  selected_device=$(sed -n "${device}p" /usr/share/sadiy_files/tmp/devices.txt)
  sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
  sed -i '9s/$/"/' /etc/default/squeezelite
  sed -i '9s/cha/"/' /etc/default/squeezelite
  name_settings=$(cat /etc/default/squeezelite)
  eval `resize` && whiptail --title "$title" --msgbox "$name_settings" $LINES $COLUMNS
}

create_list () {
  squeezelite -l > /usr/share/sadiy_files/tmp/available_list.txt
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES SPACES FROM FILE
  sed -i '1 d' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
  sed -i '$ d' /usr/share/sadiy_files/tmp/available_list.txt #REMOVES LAST LINE FROM FILE
  sed 's/-.*//' /usr/share/sadiy_files/tmp/available_list.txt > /usr/share/sadiy_files/tmp/devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/sadiy_files/tmp/devices.txt #REMOVES SPACES FROM FILE
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
          /usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_options_menu.sh
  fi
}

device_select () {
  device=$(eval `resize` && whiptail --title "$title" --inputbox "$available_list" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    service squeezelite stop
    audio_select
    service squeezelite start
    sadiy_setup
  else
    /usr/share/sadiy_files/setup/scripts/options_squeeze/squeeze_options_menu.sh
  fi
}

#------------------------------------
#REQUIREMENTS
#------------------------------------
create_list
available_list=$(cat -n /usr/share/sadiy_files/tmp/devices.txt)
display_list=$(cat -n /usr/share/sadiy_files/tmp/available_list.txt)

#------------------------------------
#MENU
#------------------------------------
device_info

#------------------------------------
#CLEANUP
#------------------------------------
rm /usr/share/sadiy_files/tmp/available_list.txt
rm /usr/share/sadiy_files/tmp/devices.txt
