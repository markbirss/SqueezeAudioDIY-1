#!/bin/sh

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

