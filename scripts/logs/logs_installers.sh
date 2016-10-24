#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTIONS
#------------------------------------
log_viewer () {
	ls /var/log/squeezeaudiodiy/ | grep $1 > /usr/share/sadiy_files/tmp/loglist.txt
	loglist=$(cat -n /usr/share/sadiy_files/tmp/loglist.txt)
	logselect=$(eval `resize` && whiptail --title "$title" --inputbox "$loglist" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
			cat -n /usr/share/sadiy_files/tmp/loglist.txt | grep $logselect > /usr/share/sadiy_files/tmp/logselect.txt
			selection=$(cat /usr/share/sadiy_files/tmp/logselect.txt | cut -c8-42)
			displaylog=$(cat /var/log/squeezeaudiodiy/$selection)
			eval `resize` && whiptail --title "Log:" --msgbox "$displaylog" $LINES $COLUMNS --scrolltext
			rm /usr/share/sadiy_files/tmp/loglist.txt
			rm /usr/share/sadiy_files/tmp/logselect.txt
	else
			echo "[ ERROR ] CANCELED" > /dev/null 2>&1
			exit
	fi
}

return_logmenu () {
	/usr/share/sadiy_files/setup/scripts/logs/logs_installers.sh
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Install logs:" 18 60 10 \
"1" "Install Squeezelite v1.8.5-802" \
"2" "Re-install Squeezelite v1.8.5-802" \
"3" "Lastest Squeezelite" \
"4" "Logitech Media Server 7.7.5" \
"5" "Logitech Media Server 7.9.x" \
"6" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		log_viewer squeeze_install
		return_logmenu
	elif [ $menu = 2 ]; then
		log_viewer sque_re-install
		return_logmenu
  elif [ $menu = 3 ]; then
		log_viewer squeeze_latest_
		return_logmenu
  elif [ $menu = 4 ]; then
		log_viewer logicms_install
		return_logmenu
  elif [ $menu = 5 ]; then
		log_viewer logicms_latest_
		return_logmenu
	elif [ $menu = 6 ]; then
		sadiy_setup
	fi
else
	exit
fi
