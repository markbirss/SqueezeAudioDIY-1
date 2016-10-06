#!/bin/bash

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
menu=$(whiptail --title "SqueezeAudioDIY | Coenraad Human" --menu "Main Menu:" 20 75 10 \
"1" "Re-install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Install stable Logitech Media Server 7.7.5 (Released 27-Nov-2014)" \
"4" "Install latest nightly Logitech Media Server v7.9" \
"5" "Display audio devices in detail" \
"6" "Change default audio device" \
"7" "Default Squeezelite options" \
"8" "View logs" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/installers/squeeze_reinstall.sh | tee /usr/share/squeeze_files/logs/squeeze_re-install/$logname
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/setup/scripts/installers/squeeze_install_latest.sh | tee /usr/share/squeeze_files/logs/squeeze_latest/$logname
  elif [ $menu = 3 ]; then
  	/usr/share/squeeze_files/setup/scripts/installers/lms_install.sh | tee /usr/share/squeeze_files/logs/lms_install/$logname
  elif [ $menu = 4 ]; then
  	/usr/share/squeeze_files/setup/scripts/installers/lms_install_latest.sh | tee /usr/share/squeeze_files/logs/lms_latest/$logname
  elif [ $menu = 5 ]; then
    /usr/share/squeeze_files/setup/scripts/audio/squeeze_audio_info.sh
	elif [ $menu = 6 ]; then
		/usr/share/squeeze_files/setup/scripts/audio/squeeze_audio.sh
  elif [ $menu = 7 ]; then
		/usr/share/squeeze_files/setup/scripts/options/squeeze_options_menu.sh
  elif [ $menu = 8 ]; then
    /usr/share/squeeze_files/setup/scripts/logs/squeeze_logs.sh
  fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
