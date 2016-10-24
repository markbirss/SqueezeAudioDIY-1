#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" 18 60 10 \
"1" "Remove Squeezelite" \
"2" "Remove Logitech Media Server" \
"3" "Remove SqueezeAudioDIY" \
"4" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/remove/squeeze_remove.sh 2>&1 | tee /var/log/squeezeaudiodiy/sque_remove+pur.log_$logname
	elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/remove/lms_remove.sh 2>&1 | tee /var/log/squeezeaudiodiy/lms_remove+pur_.log_$logname
  elif [ $menu = 3 ]; then
    cp /usr/share/sadiy_files/setup/scripts/remove/sadiy_remove.sh /tmp
    /tmp/sadiy_remove.sh
  elif [ $menu = 4 ]; then
    sadiy_setup
  fi
else
	exit
fi
