#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)
bacname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#MENU FUNCTION
#------------------------------------
options_menu () {
	/usr/share/sadiy_files/scripts/linux/squeeze_options.sh
}

#------------------------------------
#NAME FUNCTIONS
#------------------------------------
name_changer () {
	sed -i 6s/.*/SL_NAME=cha$1/ /etc/default/squeezelite
	sed -i '6s/$/"/' /etc/default/squeezelite
	sed -i '6s/cha/"/' /etc/default/squeezelite
}
name_changer_backup_settings () {
	cp /etc/default/squeezelite /usr/share/sadiy_files/settings/backups/bacname
}

name_changer_menu () {
	menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
	"1" "Change name to localhost name" \
	"2" "Enter own custom name" \
	"3" "Back" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]
	then
		if [ $menu = 1 ]; then
			name_changer $(hostname -s)
			view_settings
			service squeezelite start
			options_menu
		elif [ $menu = 2 ]; then
			inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "Please enter new name:" $LINES $COLUMNS New_Name 3>&1 1>&2 2>&3)
			exitstatus=$?
			if [ $exitstatus = 0 ]; then
				name_changer $inputbox
				view_settings
				service squeezelite start
				options_menu
			else
				options_menu
			fi
		elif [ $menu = 3 ]; then
			options_menu
		fi
	else
		exit
	fi
}

#------------------------------------
#VIEWWER FUNCTION
#------------------------------------
view_settings () {
	name_settings=$(cat /etc/default/squeezelite)
	eval `resize` && whiptail --title "Current Settings" --msgbox "$name_settings" $LINES $COLUMNS --scrolltext
}

#------------------------------------
#ARGUMENTS FUNCTIONS
#------------------------------------
arguments_deactivate () {
	service squeezelite stop
	sed -i '19s:.*:SB_EXTRA_ARGS=cha-d all=debug -f /tmp/squeezelite.log:' /etc/default/squeezelite
	sed -i '19s:$:":' /etc/default/squeezelite
	sed -i '19s:cha:":' /etc/default/squeezelite
	service squeezelite start
}

arguments_activate () {
	argumentsfile=$(cat /usr/share/sadiy_files/setup/files/squeeze_argumentsfile.txt)
	inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "$argumentsfile" $LINES $COLUMNS ? --scrolltext 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		service squeezelite start
		arguments_changer $inputbox
		view_settings
		service squeezelite start
		options_menu
	else
		options_menu
	fi
}

arguments_changer () {
	sed -i '19s:.*:SB_EXTRA_ARGS=cha'$1' -d all=debug -f /tmp/squeezelite.log:' /etc/default/squeezelite
	sed -i '19s:$:":' /etc/default/squeezelite
	sed -i '19s:cha:":' /etc/default/squeezelite
	sed -i '19s:+:\ :g' /etc/default/squeezelite
}

#------------------------------------
#AUDIO FUNCTIONS
#------------------------------------
create_audio_lists () {
  squeezelite -l > /tmp/available_list.txt
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /tmp/available_list.txt #REMOVES SPACES FROM FILE
  sed -i '1 d' /tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
  sed -i '$ d' /tmp/available_list.txt #REMOVES LAST LINE FROM FILE
  sed 's/-.*//' /tmp/available_list.txt > /tmp/devices.txt #REMOVE EVERYTHING AFTER '-' CHAR
  sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /tmp/devices.txt #REMOVES SPACES FROM FILE
	available_list=$(cat -n /tmp/devices.txt)
	display_list=$(cat -n /tmp/available_list.txt)
}

audio_device_info () {
  if (eval `resize` && whiptail \
          --title "$title" \
          --yesno "Would you like to change your audio device?: \n\n$display_list" \
          $LINES $COLUMNS $(( $LINES - 12 )) \
          --scrolltext )
        then
          audio_device_select
        else
          options_menu
  fi
}

audio_device_select () {
  device=$(eval `resize` && whiptail --title "$title" --inputbox "$available_list" $LINES $COLUMNS 1 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    service squeezelite stop
		selected_device=$(sed -n "${device}p" /tmp/devices.txt)
	  sed -i 9s/.*/SL_SOUNDCARD=cha$selected_device/ /etc/default/squeezelite
	  sed -i '9s/$/"/' /etc/default/squeezelite
	  sed -i '9s/cha/"/' /etc/default/squeezelite
	  name_settings=$(cat /etc/default/squeezelite)
	  eval `resize` && whiptail --title "$title" --msgbox "$name_settings" $LINES $COLUMNS
    service squeezelite start
  else
    options_menu
  fi
}

#------------------------------------
#SERVER FUNCTIONS
#------------------------------------
server_deactivate () {
	service squeezelite stop
	sed -i 15s/.*/#SB_SERVER_IP=cha/ /etc/default/squeezelite
	sed -i '15s/$/"/' /etc/default/squeezelite
	sed -i '15s/cha/"/' /etc/default/squeezelite
	service squeezelite start
	view_settings
	options_menu
}

server_changer () {
	sed -i 15s/.*/SB_SERVER_IP=cha$1/ /etc/default/squeezelite
	sed -i '15s/$/"/' /etc/default/squeezelite
	sed -i '15s/cha/"/' /etc/default/squeezelite
}

server_pointer () {
	inputbox=$(eval `resize` && whiptail --title "$title" --inputbox "Please enter arguments:" $LINES $COLUMNS x.x.x.x 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		service squeezelite start
		server_changer $inputbox
		view_settings
		service squeezelite start
		options_menu
	else
		options_menu
	fi
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Squeezelite options menu:" 18 60 10 \
"1" "View current settings" \
"2" "View the audio devices in detail" \
"3" "Change the default audio device" \
"4" "Set Squeezelite player name" \
"5" "Set extra arguments to Squeezelite" \
"6" "Deactivate extra arguments" \
"7" "Point Squeezelite to your Server via IPv4" \
"8" "Deactivate custom server IPv4 address" \
"9" "Back" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
		#VIEW SETTINGS OF SQUEEZELITE
		view_settings
		options_menu
	elif [ $menu = 2 ]; then
		#VIEW AUDIO DEVICES IN DETAIL AND SELECT ONE
		create_audio_lists
    audio_device_info
  elif [ $menu = 3 ]; then
    #CHANGE DEFAULT AUDIO DEVICE
    create_audio_lists
    audio_device_select
	elif [ $menu = 4 ]; then
    #SET SQUEEZELITE NAME
    service squeezelite stop
    name_changer_backup_settings
		name_changer_menu
	elif [ $menu = 5 ]; then
		#SET ARGUMENTS TO SQUEEZELITE
    arguments_activate
	elif [ $menu = 6 ]; then
		#DEACTIVATE EXTRA ARGUMENTS BY USER
		arguments_activate
	elif [ $menu = 7 ]; then
		#POINT SQUEEZELITE TO SERVER
    server_pointer
	elif [ $menu = 8 ]; then
		#DEACTIVATE CUSTOM SQUEEZELITE SERVER
		server_deactivate
	elif [ $menu = 9 ]; then
		sadiy_setup
  fi
else
	exit
fi
