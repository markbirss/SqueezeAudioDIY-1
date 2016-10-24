#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" 18 60 10 \
"1" "Permanent mount" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/options_lms/lms_network_mount.sh
  fi
else
	exit
fi
