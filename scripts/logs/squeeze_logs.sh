#!/bin/bash

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "SqueezeAudioDIY | Coenraad Human" --menu "Logs:" 20 75 10 \
"1" "Install Squeezelite v1.8.5-802 log" \
"2" "Re-install Squeezelite v1.8.5-802 log" \
"3" "Install latest Squeezelite available log" \
"4" "Install Logitech Media Server 7.7.5 log" \
"5" "Install latest Logitech Media Server v7.9 log" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then

	elif [ $menu = 2 ]; then

  elif [ $menu = 3 ]; then

  elif [ $menu = 4 ]; then

  elif [ $menu = 5 ]; then
      
  fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
