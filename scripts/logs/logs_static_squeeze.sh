#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

displaylog=$(cat /var/log/squeezeaudiodiy/squeezelite.log)
eval `resize` && whiptail --title "Log:" --msgbox "$displaylog" $LINES $COLUMNS --scrolltext
