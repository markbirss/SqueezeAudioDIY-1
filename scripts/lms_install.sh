#!/bin/bash

#------------------------------------
#INSTALL
#------------------------------------
cd /usr/share/squeeze_files/lms/stable
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/
download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/squeeze_files/lms/stable/$install
service logitechmediaserver start
echo Done.
rm /usr/share/squeeze_files/lms/stable/index*
exit
