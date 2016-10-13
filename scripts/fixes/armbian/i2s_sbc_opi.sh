#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#REBOOT
#------------------------------------
rebootpi () {
  if (whiptail --title "$title" --yes-button "Reboot" --no-button "Exit" --yesno "Reboot is neccessary, would you like to reboot the system?" 10 60) then
    shutdown -r now
  else
    echo [ ERROR ] CANCELED, PLEASE REBOOT.
    exit
  fi
}

#------------------------------------
#RESOURCES
#------------------------------------
#http://forum.armbian.com/index.php/topic/759-tutorial-i2s-on-orange-pi-h3/
