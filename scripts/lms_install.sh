#!/bin/bash

#------------------------------------
#INSTALL
#------------------------------------
mkdir /usr/share/squeeze_files/lms_install/
wget ‐‐directory-prefix=/usr/share/squeeze_files/lms_install/ http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/
download=$(grep logitechmediaserver_....._all.deb /usr/share/squeeze_files/lms_install/index.html | cut -c82-114)
wget ‐‐directory-prefix=/usr/share/squeeze_files/lms_install/ http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
service logitechmediaserver stop
install=$(ls /usr/share/squeeze_files/lms_install/ | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/squeeze_files/lms_install/$install
service logitechmediaserver start
echo Done.
rm /usr/share/squeeze_files/lms_install/index*
exit
