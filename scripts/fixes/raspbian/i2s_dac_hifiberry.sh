#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)



#------------------------------------
#LINUX 3.12.x
#------------------------------------
linux3.12.x+ () {
  modules=$(whiptail --title "$title" --menu "Choose your package manager:" 20 60 10 \
  "1" "DAC/DAC+ Light" \
  "2" "DAC+ Standard/Pro" \
  "3" "Digi and Digi+" \
  "4" "Amp and Amp+" 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]
  then
    if [ $modules = 1 ]; then
       echo "snd_soc_bcm2708" >> /etc/modules
       echo "bcm2708_dmaengine" >> /etc/modules
       echo "snd_soc_pcm5102a" >> /etc/modules
       echo "snd_soc_hifiberry_dac" >> /etc/modules
    elif [ $modules = 2 ]; then
       echo "snd_soc_bcm2708" >> /etc/modules
       echo "bcm2708_dmaengine" >> /etc/modules
       echo "snd_soc_pcm512x" >> /etc/modules
       echo "snd_soc_hifiberry_dacplus" >> /etc/modules
    elif [ $modules = 3 ]; then
       echo "snd_soc_bcm2708" >> /etc/modules
       echo "bcm2708_dmaengine" >> /etc/modules
       echo "snd_soc_hifiberry_digi" >> /etc/modules
    elif [ $modules = 4 ]; then
       echo "snd_soc_bcm2708"	>> /etc/modules
       echo "bcm2708_dmaengine"	>> /etc/modules
       echo "snd_soc_hifiberry_amp"	>> /etc/modules
    fi
  else
    /usr/share/squeeze_files/setup/scripts/fixes/i2s_fixes_menu.sh
  fi
}

#------------------------------------
#LINUX 3.18.x/4.x+
#------------------------------------
linux3.18.x-4.x+ () {
  modules=$(whiptail --title "$title" --menu "Choose your package manager:" 20 60 10 \
  "1" "DAC/DAC+ Light" \
  "2" "DAC+ Standard/Pro" \
  "3" "Digi and Digi+" \
  "4" "Amp and Amp+" 3>&1 1>&2 2>&3)
  exitstatus=$?
  if [ $exitstatus = 0 ]
  then
    if [ $modules = 1 ]; then
  	   echo "dtoverlay=hifiberry-dac" >> /boot/config.txt
    elif [ $modules = 2 ]; then
  	   echo "dtoverlay=hifiberry-dacplus" >> /boot/config.txt
    elif [ $modules = 3 ]; then
  	   echo "dtoverlay=hifiberry-digi" >> /boot/config.txt
    elif [ $modules = 4 ]; then
  	   echo "dtoverlay=hifiberry-amp" >> /boot/config.txt
    fi
  else
    /usr/share/squeeze_files/setup/scripts/fixes/i2s_fixes_menu.sh
  fi
}

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
#MENU
#------------------------------------
menu=$(eval `resize` && whiptail --title "$title" --menu "Menu:" $LINES $COLUMNS $(( $LINES - 10 )) \
"1" "Hifiberry for Linux Kernel 3.12.x" \
"2" "Hifiberry for Linux Kernel 3.18.x/4.x+" \
"3" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
  if [ $menu = 1 ]; then
     linux3.18.x-4.x+
     rebootpi
  elif [ $menu = 2 ]; then
     linux3.12.x+
     rebootpi
  elif [ $menu = 3 ]; then
    /usr/share/squeeze_files/setup/scripts/fixes/i2s_fixes_menu.sh
  fi
else
  exit
fi

#------------------------------------
#RESOURCES
#------------------------------------
#https://www.hifiberry.com/guides/hifiberry-software-configuration/
#https://www.hifiberry.com/guides/configuring-linux-3-18-x/
#https://support.hifiberry.com/hc/en-us/articles/205377651-Configuring-Linux-4-x-or-higher
