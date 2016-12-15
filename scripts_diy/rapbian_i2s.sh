#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

#------------------------------------
#CONFIGURING BOOT.CONFIG
#------------------------------------
#Linux 3.18.x/4.x or higher
#------------------------------------
sed -i 's/#dtparam=i2s=on/dtparam=i2s=on/g' /boot/config.txt

#------------------------------------
#REBOOT PI
#------------------------------------
if (whiptail --title "$title" --yes-button "Reboot" --no-button "Exit" --yesno "Would you like to reboot the system?" 10 60) then
  shutdown -r now
else
  echo [ ERROR ] CANCELED, PLEASE REBOOT.
  exit
fi
