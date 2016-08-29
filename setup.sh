#!/bin/bash
#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
	echo "Running as root."
else
  echo "Run script as root."
  exit
fi

#------------------------------------
#MENU
#------------------------------------
OPTION=$(whiptail --title "ictinus2310 Squeezelite Setup" --menu "Main Menu" 20 60 10 \
"1" "Install Squeezelite" \
"2" "Update Squeezelite" \
"3" "Change default audio device" \
"4" "Change name of player" \
"5" "HifiBerry I2S DAC Setup for Raspberry Pi" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $OPTION = 1 ]; then
		chmod +x ./squeeze_install.sh
		./squeeze_install.sh
	elif [ $OPTION = 2]; then
		chmod +x ./squeeze_update.sh
		./squeeze_update.sh
	elif [ $OPTION = 3 ]; then
		chmod +x ./squeeze_audio.sh
		./squeeze_audio.sh
	elif [ $OPTION = 4 ]; then
		chmod +x ./squeeze_name.sh
		./squeeze_name.sh
	elif [ $OPTION = 5 ]; then
		chmod +x ./squeeze_rpi_hifiberry.sh
		./squeeze_rpi_hifiberry.sh
	fi
else
	echo "You chose cancel."
	exit
fi
