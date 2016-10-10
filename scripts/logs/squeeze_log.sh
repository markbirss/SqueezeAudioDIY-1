#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#FUNCTIONS
#------------------------------------
displaylog=$(cat /usr/share/squeeze_files/logs/squeeze/log.txt)
eval `resize` && whiptail --title "Log:" --msgbox "$displaylog" $LINES $COLUMNS --scrolltext
