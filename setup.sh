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
"4" "Change name of player" \
"5" "HifiBerry I2S DAC Setup for Raspberry Pi" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		chmod +x ./scripts/squeeze_install.sh
		./scripts/squeeze_install.sh
	elif [ $menu = 2]; then
		chmod +x ./scripts/squeeze_update.sh
		./scripts/squeeze_update.sh
	elif [ $menu = 3 ]; then
		chmod +x ./scripts/squeeze_audio.sh
		./scripts/squeeze_audio.sh
	elif [ $menu = 4 ]; then
		chmod +x ./scripts/squeeze_name.sh
		./scripts/squeeze_name.sh
	elif [ $menu = 5 ]; then
		chmod +x ./scripts/squeeze_rpi_hifiberry.sh
		./scripts/squeeze_rpi_hifiberry.sh
	fi
else
	echo "[ ERROR ] CANCELED"
	exit
fi
