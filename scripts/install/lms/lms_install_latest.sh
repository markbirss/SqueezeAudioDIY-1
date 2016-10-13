#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#INSTALL
#------------------------------------
cd /usr/share/sadiy_files/installers/lms_nightly/
wget http://downloads.slimdevices.com/nightly/?ver=7.9 > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INDEX RECEIVED"
  else
    echo "[ ERROR ] INDEX DOWNLOAD FAILED"
fi
download=$(grep logitechmediaserver_7.9.0~.........._all.deb ./index.html?ver=7.9 | cut -c27-85)
echo "DOWNLOADING LMS 7.9.X"
wget http://downloads.slimdevices.com/nightly/$download > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LMS 7.9.X DOWNLOADED"
  else
    echo "[ ERROR ] LMS 7.9.X DOWNLOAD FAILED"
fi
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_7.9.0~.........._all.deb)
dpkg -i /usr/share/sadiy_files/installers/lms_nightly/$install
rm /usr/share/sadiy_files/installers/lms_nightly/index*
sadiy_setup
