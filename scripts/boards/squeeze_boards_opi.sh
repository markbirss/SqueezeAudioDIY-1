#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

#------------------------------------
#REBOOT PI
#------------------------------------
if (whiptail --title "$title" --yes-button "Reboot" --no-button "Exit" --yesno "Would you like to reboot the system?" 10 60) then
  shutdown -r now
else
  echo [ ERROR ] CANCELED, PLEASE REBOOT.
  exit
fi
