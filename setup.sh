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
		chmod +x ./squeeze_winstall.sh
		./squeeze_winstall.sh
	elif [ $OPTION = 2]; then
		chmod +x ./squeeze_wupdate.sh
		./squeeze_wupdate.sh
	elif [ $OPTION = 3 ]; then
		chmod +x ./squeeze_waudio.sh
		./squeeze_waudio.sh
	elif [ $OPTION = 4 ]; then
		chmod +x ./squeeze_wname.sh
		./squeeze_wname.sh
	elif [ $OPTION = 5 ]; then
		chmod +x ./squeeze_wrpi_hifiberry.sh
		./squeeze_wrpi_hifiberry.sh
	fi
else
	echo "You chose cancel."
	exit
fi
