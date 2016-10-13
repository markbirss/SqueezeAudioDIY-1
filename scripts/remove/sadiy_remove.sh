#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)
if (eval `resize` && whiptail \
        --title "$title" \
        --yesno "Are you sure you want to remove SqueezeAudioDIY?" \
        $LINES $COLUMNS $(( $LINES - 12 )) \
        --scrolltext )
      then
        rm -R /var/log/squeezeaudiodiy > /dev/null 2>&1
        rm -R /usr/share/sadiy_files > /dev/null 2>&1
        rm -R /usr/share/sadiy_files > /dev/null 2>&1
      else
        sadiy_setup
fi
