#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

sadiy_remove () {
  if (whiptail \
          --title "$title" \
          --yesno "Are you sure you want to remove SqueezeAudioDIY?" \
          18 60 10 )
        then
          rm /usr/bin/squeeze_setup > /dev/null 2>&1
          rm /usr/bin/sadiy_setup > /dev/null 2>&1
          rm -R /rmp/squeezeaudiodiy > /dev/null 2>&1
          rm -R /usr/share/sadiy_files > /dev/null 2>&1
          rm -R /usr/share/sadiy_files > /dev/null 2>&1
        else
          sadiy_setup
  fi
}

all_remove () {
  if (whiptail \
          --title "$title" \
          --yesno "Are you sure you want to remove everything?" \
          18 60 10 )
        then
          apt-get remove --purge logitechmediaserver
          apt-get remove --purge squeezelite
          rm /usr/bin/squeeze_setup > /dev/null 2>&1
          rm /usr/bin/sadiy_setup > /dev/null 2>&1
          rm -R /usr/share/sadiy_files > /dev/null 2>&1
          rm -R /usr/share/sadiy_files > /dev/null 2>&1
        else
          sadiy_setup
  fi
}

if (whiptail --title "$title" --yes-button "Remove SADIY" --no-button "Remove Everything" --yesno "Select one of the options below:" 18 60 10) then
  sadiy_remove
else
  all_remove
fi
