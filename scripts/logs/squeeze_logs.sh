#!/bin/bash

#------------------------------------
#FUNCTION
#------------------------------------
log_viewer () {
	ls $1/ > /usr/share/squeeze_files/tmp/loglist.txt
	loglist=$(cat -n /usr/share/squeeze_files/tmp/loglist.txt)
	logselect=$(whiptail --title "Available logs:" --inputbox "$loglist" 30 60 Number 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
			cat -n /usr/share/squeeze_files/tmp/loglist.txt | grep "^ *$logselect" > /usr/share/squeeze_files/tmp/logselect.txt
			selection=$(cat /usr/share/squeeze_files/tmp/logselect.txt | cut -c8-22)
			displaylog=$(cat $1/$selection)
			eval `resize` && whiptail --title "Squeezelite install log:" --msgbox "$displaylog" $LINES $COLUMNS --scrolltext
			rm /usr/share/squeeze_files/tmp/loglist.txt
			rm /usr/share/squeeze_files/tmp/logselect.txt
	else
			echo "[ ERROR ] CANCELED"
			exit
	fi
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "SqueezeAudioDIY | Coenraad Human" --menu "Logs:" 20 75 10 \
"1" "Install Squeezelite v1.8.5-802 log" \
"2" "Re-install Squeezelite v1.8.5-802 log" \
"3" "Install latest Squeezelite available log" \
"4" "Install Logitech Media Server 7.7.5 log" \
"5" "Install latest Logitech Media Server v7.9 log" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_install
	elif [ $menu = 2 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_re-install
  elif [ $menu = 3 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_latest
  elif [ $menu = 4 ]; then
		log_viewer /usr/share/squeeze_files/logs/lms_install
  elif [ $menu = 5 ]; then
		log_viewer /usr/share/squeeze_files/logs/lms_latest
	else
	echo "[ ERROR ] CANCELED"
	exit
	fi
fi
