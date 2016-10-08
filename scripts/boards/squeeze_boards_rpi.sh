#!/bin/bash
title=$(SqueezeAudioDIY 1.3 | Coenraad Human)

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

#------------------------------------
#CONFIGURING BOOT.CONFIG
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
