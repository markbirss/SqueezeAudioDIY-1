#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#FUNCTIONS
#------------------------------------
lms_remove () {
  if (whiptail \
          --title "$title" \
          --yesno "Are you sure you want to remove LMS?" \
          18 60 10 )
        then
          apt-get remove --purge logitechmediaserver
          sadiy_setup
        else
          sadiy_setup
  fi
}

squeeze_remove () {
  if (whiptail \
          --title "$title" \
          --yesno "Are you sure you want to remove Squeezelite?" \
          18 60 10 )
        then
          apt-get remove --purge squeezelite
          sadiy_setup
        else
          sadiy_setup
  fi
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Uninstall menu:" 18 60 10 \
"1" "Remove Squeezelite" \
"2" "Remove Logitech Media Server" \
"3" "Remove SqueezeAudioDIY" \
"4" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		squeeze_remove 2>&1 | tee /var/log/squeezeaudiodiy/sque_remove+pur.log_$logname
	elif [ $menu = 2 ]; then
		lms_remove 2>&1 | tee /var/log/squeezeaudiodiy/lms_remove+pur_.log_$logname
  elif [ $menu = 3 ]; then
    cp /usr/share/sadiy_files/setup/files/uninstall.sh /tmp
    /tmp/uninstall.sh
  elif [ $menu = 4 ]; then
    sadiy_setup
  fi
else
	exit
fi
