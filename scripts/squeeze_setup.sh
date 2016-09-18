#!/bin/bash
#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
	echo "[ OK ] RUNNING AS ROOT"
else
  echo "[ ERROR ] RUN SCRIPT AS ROOT"
  exit
fi

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "Squeezelite Setup | ictinus2310 " --menu "Main Menu:" 20 60 10 \
"1" "Install Squeezelite" \
"2" "Update Squeezelite" \
"3" "Change default audio device" \
"4" "Change name of player" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		chmod +x /usr/bin/squeeze_files/setup/scripts/squeeze_install.sh
		/usr/bin/squeeze_files/setup/scripts/squeeze_install.sh
	elif [ $menu = 2]; then
		chmod +x /usr/bin/squeeze_files/setup/scripts/squeeze_update.sh
		/usr/bin/squeeze_files/setup/scripts/squeeze_update.sh
	elif [ $menu = 3 ]; then
		chmod +x /usr/bin/squeeze_files/setup/scripts/squeeze_audio.sh
		/usr/bin/squeeze_files/setup/scripts/squeeze_audio.sh
	elif [ $menu = 4 ]; then
		chmod +x ./scripts/squeeze_name.sh
		/usr/bin/squeeze_files/setup/scripts/squeeze_name.sh
	fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
