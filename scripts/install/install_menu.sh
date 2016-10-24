#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" 18 60 10 \
"1" "Re-install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Install stable Logitech Media Server 7.7.5" \
"4" "Install stable Logitech Media Server 7.8.0" \
"5" "Install latest nightly Logitech Media Server 7.8.X" \
"6" "Install latest nightly Logitech Media Server 7.9.X" \
"7" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/sadiy_files/setup/scripts/install/squeeze_reinstall.sh 2>&1 | tee /var/log/squeezeaudiodiy/sque_re-install.log_$logname
	elif [ $menu = 2 ]; then
		/usr/share/sadiy_files/setup/scripts/install/squeeze_install_latest.sh 2>&1 | tee /var/log/squeezeaudiodiy/squeeze_latest_.log_$logname
  elif [ $menu = 3 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install_7.7.5.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.7.5in.log_$logname
  elif [ $menu = 4 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install_7.8.0.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.8.0in.log_$logname
	elif [ $menu = 5 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install_7.8.x.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.8.xin.log_$logname
  elif [ $menu = 6 ]; then
  	/usr/share/sadiy_files/setup/scripts/install/lms_install_7.9.x.sh 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.9.xin.log_$logname
	elif [ $menu = 7 ]; then
  	sadiy_setup
	fi
else
	exit
fi
