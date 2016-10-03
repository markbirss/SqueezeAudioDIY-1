#!/bin/bash

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
"1" "Install Squeezelite v1.8.5-802" \
"2" "Install latest Squeezelite available" \
"3" "Display audio devices in detail" \
"4" "Change default audio device" \
"5" "Change name of player" \
"6" "Install stable Logitech Media Server 7.7.5 (Released 27-Nov-2014)" \
"7" "Install latest nightly Logitech Media Server v7.9" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/squeeze_install.sh
	elif [ $menu = 2 ]; then
		/usr/share/squeeze_files/squeeze_install_latest.sh
  elif [ $menu = 3 ]; then
    chmod +x /usr/share/squeeze_files/setup/scripts/squeeze_audio_info.sh
    /usr/share/squeeze_files/setup/scripts/squeeze_audio_info.sh
	elif [ $menu = 4 ]; then
		/usr/share/squeeze_files/setup/scripts/squeeze_audio.sh
  elif [ $menu = 5 ]; then
		/usr/share/squeeze_files/setup/scripts/squeeze_name.sh
  elif [ $menu = 6 ]; then
  	/usr/share/squeeze_files/setup/scripts/lms_install.sh
  elif [ $menu = 7 ]; then
  	/usr/share/squeeze_files/setup/scripts/lms_install_latest.sh
  fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
