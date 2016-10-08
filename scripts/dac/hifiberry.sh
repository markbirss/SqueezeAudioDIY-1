#!/bin/sh

#https://www.hifiberry.com/guides/hifiberry-software-configuration/
#https://www.hifiberry.com/guides/configuring-linux-3-18-x/
#https://support.hifiberry.com/hc/en-us/articles/205377651-Configuring-Linux-4-x-or-higher

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
modules=$(whiptail --title "Squeezelite Setup | ictinus2310" --menu "Choose your package manager:" 20 60 10 \
"1" "DAC/DAC+ Light" \
"2" "DAC+ Standard/Pro" \
"3" "Digi and Digi+" \
"4" "Amp and Amp+" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
  echo "[ OK ] MENU"
else
	echo "[ ERROR ] YOU CHOSE CANCEL"
	exit
fi

#------------------------------------
#Linux 3.18.x/4.x or higher
#------------------------------------
if [ $modules = 1 ]; then
	echo "dtoverlay=hifiberry-dac" >> /boot/config.txt
elif [ $modules = 2 ]; then
	echo "dtoverlay=hifiberry-dacplus" >> /boot/config.txt
elif [ $modules = 3 ]; then
	echo "dtoverlay=hifiberry-digi" >> /boot/config.txt
elif [ $modules = 4 ]; then
	echo "dtoverlay=hifiberry-amp" >> /boot/config.txt
fi

#------------------------------------
#REBOOT PI
#------------------------------------
if (whiptail --title "squeeze_hifiberry | ictinus2310" --yes-button "Reboot" --no-button "Exit" --yesno "Would you like to reboot the system?" 10 60) then
  shutdown -r now
else
  echo [ ERROR ] CANCELED, PLEASE REBOOT.
  exit
fi
