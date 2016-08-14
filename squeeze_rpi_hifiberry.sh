#!/bin/sh

#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
  tput setaf 3; echo "Running as root."
else
  tput setaf 3; echo "Run script as root."
  exit
fi

#------------------------------------
#CONFIGURING BOOT.CONFIG
#------------------------------------
sed -i 's/#dtparam=i2s=on/dtparam=i2s=on/g' /boot/config.txt
echo "dtoverlay=hifiberry-dac" >> /boot/config.txt
tput setaf 3; echo "Configured /boot/config.txt for I2S DAC."

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
echo "snd_soc_bcm2708_i2s" >> /etc/modules
echo "bcm2708_dmaengine" >> /etc/modules
echo "snd_soc_pcm5102a" >> /etc/modules
echo "snd_soc_hifiberry_dac" >> /etc/modules
tput setaf 3; echo "Modules added to /etc/modules file."

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
tput setaf 3; echo "System needs to reboot for DAC to activate."
exit
