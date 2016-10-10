#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Re-install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Install stable Logitech Media Server 7.7.5" \
"4" "Install latest nightly Logitech Media Server v7.9.x" \
"5" "Squeezelite audio device" \
"6" "Squeezelite options" \
"7" "View logs of installers" \
"8" "Fixes for I2S use" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/installers/squeeze_reinstall.sh 2>&1 | tee /usr/share/squeeze_files/logs/squeeze_re-install/$logname
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/installers/squeeze_install_latest.sh 2>&1 | tee /usr/share/squeeze_files/logs/squeeze_latest/$logname
  elif [ $menu = 3 ]; then
  	/usr/share/squeeze_files/setup/scripts/installers/lms_install.sh 2>&1 | tee /usr/share/squeeze_files/logs/lms_install/$logname
  elif [ $menu = 4 ]; then
  	/usr/share/squeeze_files/setup/scripts/installers/lms_install_latest.sh 2>&1 | tee /usr/share/squeeze_files/logs/lms_latest/$logname
  elif [ $menu = 5 ]; then
    /usr/share/squeeze_files/setup/scripts/options/audio/squeeze_audio.sh
  elif [ $menu = 6 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
  elif [ $menu = 7 ]; then
    /usr/share/squeeze_files/setup/scripts/logs/logs_installers.sh
  elif [ $menu = 8 ];then
    /usr/share/squeeze_files/setup/scripts/fixes/i2s_fixes_menu.sh
  fi
else
	exit
fi
