#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#------------------------------------
#FUNCTIONS
#------------------------------------
install_lms () {
  service logitechmediaserver stop
  dpkg -i /usr/share/sadiy_files/installers/lms_stable/logitechmediaserver_7.7.5_all.deb
  sadiy_setup
}

download_lms () {
  wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/ > /dev/null 2>&1
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] INDEX RECEIVED"
    else
      echo "[ ERROR ] INDEX DOWNLOAD FAILED"
  fi
  download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
  echo "DOWNLOADING LMS 7.7.5"
  wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
  exitstatus=$?
  if [ $exitstatus = 0 ]
    then
      echo "[ OK ] LMS 7.7.5 DOWNLOADED"
    else
      echo "[ ERROR ] LMS 7.7.5 DOWNLOAD FAILED"
  fi
}

#------------------------------------
#GET SITE INFORMATION
#------------------------------------
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/ > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INDEX RECEIVED"
  else
    echo "[ ERROR ] INDEX DOWNLOAD FAILED"
fi

#------------------------------------
#COMPARE VERSIONS & INSTALL PACKAGE
#------------------------------------
cd /usr/share/sadiy_files/installers/lms_stable/
newfile=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
oldfile=$(ls | grep logitechmediaserver_7.7.5_all)

if [ $newfile = $oldfile ]
then
	echo -n "There is a previous download of v7.7.5 , would you like to re-install it? (y/n): "
	read answer
  if [ $answer = y]
  then
    service logitechmediaserver stop
    dpkg -i ./$oldfile
    rm /usr/share/sadiy_files/installers/lms_stable/index*
	  sadiy_setup
  else
    rm /usr/share/sadiy_files/installers/lms_stable/index*
    sadiy_setup
else
	echo "No previous download found, downloading v7.7.5"
  download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
  wget http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/$download
	service logitechmediaserver stop
	install=$(ls | grep LogitechMediaServer_v7.7.5)
	dpkg -i ./$install
  rm /usr/share/sadiy_files/installers/lms_stable/index*
	sadiy_setup
fi
