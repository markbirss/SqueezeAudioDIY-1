#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Re-install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Install stable Logitech Media Server 7.7.5" \
"4" "Install latest nightly Logitech Media Server 7.9.X" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/install/squeeze_reinstall.sh 2>&1 | tee /var/log/squeezeaudiodiy/sque_re-install.log_$logname
	elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/install/squeeze_install_latest.sh 2>&1 | tee /var/log/squeezeaudiodiy/squeeze_latest_.log_$logname
  elif [ $menu = 3 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_install.log_$logname
  elif [ $menu = 4 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install_latest.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_latest_.log_$logname
  fi
else
	exit
fi
