#!/bin/bash

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#INSTALL
#------------------------------------
cd /usr/share/squeeze_files/installers/lms_stable/
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/
download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
service logitechmediaserver stop &>> /usr/share/squeeze_files/logs/lms_install/$logname #LOG SYSTEM
install=$(ls | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/squeeze_files/installers/lms_stable/$install
echo Done.
rm /usr/share/squeeze_files/installers/lms_stable/index*
exit
