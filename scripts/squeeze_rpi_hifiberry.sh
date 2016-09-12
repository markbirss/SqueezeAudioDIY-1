#!/bin/sh

#------------------------------------
#CONFIGURING BOOT.CONFIG
#------------------------------------
sed -i 's/#dtparam=i2s=on/dtparam=i2s=on/g' /boot/config.txt
echo "dtoverlay=hifiberry-dac" >> /boot/config.txt
echo "[ OK ] CONFIGURED I2S DAC"

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
echo "snd_soc_bcm2708_i2s" >> /etc/modules
echo "bcm2708_dmaengine" >> /etc/modules
echo "snd_soc_pcm5102a" >> /etc/modules
echo "snd_soc_hifiberry_dac" >> /etc/modules
echo "[ OK ] MODULES ADDED"

#------------------------------------
#REBOOT PI
#------------------------------------
if (whiptail --title "squeeze_hifiberry | ictinus2310" --yes-button "Reboot" --no-button "Exit" --yesno "Would you like to reboot the system?" 10 60) then
  shutdown -r now
else
  echo [ ERROR ] CANCELED, PLEASE REBOOT.
  exit
fi
