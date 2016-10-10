#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Main Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Armbian - Orange Pi" \
"2" "Raspbian - Raspberry Pi" \
"3" "Raspbian - Hifiberry Products"
"4" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		/usr/share/squeeze_files/setup/scripts/fixes/armbian/i2s_sbc_opi.sh
	elif [ $menu = 2 ]; then
    /usr/share/squeeze_files/setup/scripts/fixes/raspbian/i2s_sbc_rpi.sh
	elif [ $menu = 3 ]; then
    /usr/share/squeeze_files/setup/scripts/fixes/raspbian/i2s_dac_hifiberry.sh
	elif [ $menu = 4 ]; then
		squeeze_setup
  fi
else
	exit
fi
