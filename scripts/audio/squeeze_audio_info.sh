#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#AUDIO DEVICES AVAILABLE
#------------------------------------
squeezelite -l > /usr/share/squeeze_files/tmp/available_list.txt

#------------------------------------
#CREATE AVAILABLE LIST
#------------------------------------
sed -i -e 's/^[ \t]*//' -e 's/[ \t]*$//' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES SPACES FROM FILE
sed -i '1 d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES FIRST LINE FROM FILE
sed -i '$ d' /usr/share/squeeze_files/tmp/available_list.txt #REMOVES LAST LINE FROM FILE
display_list=$(cat -n /usr/share/squeeze_files/tmp/available_list.txt)

#------------------------------------
#QUESTION
#------------------------------------
if (eval `resize` && whiptail \
        --title "$title" \
        --yesno "Would you like to change your audio device?: \n\n$display_list" \
        $LINES $COLUMNS $(( $LINES - 12 )) \
        --scrolltext ) then
        /usr/share/squeeze_files/setup/scripts/audio/squeeze_audio.sh
    else
        squeeze_setup
fi
