#!/bin/bash
title=$(SqueezeAudioDIY 1.3 | Coenraad Human)

#------------------------------------
#FUNCTIONS
#------------------------------------
log_viewer () {
	ls $1/ > /usr/share/squeeze_files/tmp/loglist.txt
	loglist=$(cat -n /usr/share/squeeze_files/tmp/loglist.txt)
	logselect=$(eval `resize` && whiptail --title "$title" --inputbox "$loglist" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
			cat -n /usr/share/squeeze_files/tmp/loglist.txt | grep "^ *$logselect" > /usr/share/squeeze_files/tmp/logselect.txt
			selection=$(cat /usr/share/squeeze_files/tmp/logselect.txt | cut -c8-22)
			displaylog=$(cat $1/$selection)
			eval `resize` && whiptail --title "Log:" --msgbox "$displaylog" $LINES $COLUMNS --scrolltext
			rm /usr/share/squeeze_files/tmp/loglist.txt
			rm /usr/share/squeeze_files/tmp/logselect.txt
	else
			echo "[ ERROR ] CANCELED" > /dev/null 2>&1
			exit
	fi
}

return_logmenu () {
	/usr/share/squeeze_files/setup/scripts/logs/squeeze_logs.sh
}

#------------------------------------
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Logs:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Install Squeezelite v1.8.5-802 log" \
"2" "Re-install Squeezelite v1.8.5-802 log" \
"3" "Install latest Squeezelite available log" \
"4" "Install Logitech Media Server 7.7.5 log" \
"5" "Install latest Logitech Media Server v7.9 log" \
"6" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_install
		return_logmenu
	elif [ $menu = 2 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_re-install
		return_logmenu
  elif [ $menu = 3 ]; then
		log_viewer /usr/share/squeeze_files/logs/squeeze_latest
		return_logmenu
  elif [ $menu = 4 ]; then
		log_viewer /usr/share/squeeze_files/logs/lms_install
		return_logmenu
  elif [ $menu = 5 ]; then
		log_viewer /usr/share/squeeze_files/logs/lms_latest
		return_logmenu
	elif [ $menu = 6 ]; then
		squeeze_setup
	else
		exit
	fi
fi
