#!/bin/sh

#------------------------------------
#CONFIGURING BOOT.CONFIG
#------------------------------------
sed -i 's/#dtparam=i2s=on/dtparam=i2s=on/g' /boot/config.txt
echo "dtoverlay=hifiberry-dac" >> /boot/config.txt
echo "Configured /boot/config.txt for I2S DAC."

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
echo "snd_soc_bcm2708_i2s" >> /etc/modules
echo "bcm2708_dmaengine" >> /etc/modules
echo "snd_soc_pcm5102a" >> /etc/modules
echo "snd_soc_hifiberry_dac" >> /etc/modules
echo "Modules added to /etc/modules file."

#------------------------------------
#ADDING MODULES FOR DAC
#------------------------------------
echo "System needs to reboot for DAC to activate."
exit
