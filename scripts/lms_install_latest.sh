#!/bin/bash

#------------------------------------
#INSTALL
#------------------------------------
cd /usr/share/squeeze_files/lms/nightly
wget http://downloads.slimdevices.com/nightly/?ver=7.9
download=$(grep logitechmediaserver_7.9.0~.........._all.deb ./index.html?ver=7.9 | cut -c27-85)
wget http://downloads.slimdevices.com/nightly/$download
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_7.9.0~.........._all.deb)
dpkg -i $install
service logitechmediaserver start
echo Done.
rm ./index*
exit
