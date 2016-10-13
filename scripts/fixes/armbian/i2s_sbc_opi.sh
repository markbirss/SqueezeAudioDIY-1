#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTION
#------------------------------------
rebootpi () {
  if (whiptail --title "$title" --yes-button "Reboot" --no-button "Exit" --yesno "Reboot is neccessary, would you like to reboot the system?" 10 60) then
    shutdown -r now
  else
    echo [ ERROR ] CANCELED, PLEASE REBOOT.
    exit
  fi
}

bin2fex /boot/script.bin /usr/share/sadiy_files/tmp/script.fex
sed -i 's:.*twi_used.*:twi_used = 0:' /usr/share/sadiy_files/tmp/script.fex
sed -i 's:.*daudio_used.*:daudio_used = 1:' /usr/share/sadiy_files/tmp/script.fex
fex2bin /usr/share/sadiy_files/tmp/script.fex /boot/script.bin
rebootpi

#------------------------------------
#RESOURCES
#------------------------------------
#http://forum.armbian.com/index.php/topic/759-tutorial-i2s-on-orange-pi-h3/
