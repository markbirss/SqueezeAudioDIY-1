#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#INSTALL
#------------------------------------
cd /usr/share/sadiy_files/installers/lms_stable/
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/
download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/sadiy_files/installers/lms_stable/$install
rm /usr/share/sadiy_files/installers/lms_stable/index*
sadiy_setup
