#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

lms_install_7.7.5 () {
cd /usr/share/sadiy_files/installers/lms_stable/
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
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/sadiy_files/installers/lms_stable/$install
rm /usr/share/sadiy_files/installers/lms_stable/index*
sadiy_setup
}

lms_install_7.8.0 () {
cd /usr/share/sadiy_files/installers/lms_stable/
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/ > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INDEX RECEIVED"
  else
    echo "[ ERROR ] INDEX DOWNLOAD FAILED"
fi
download=$(grep logitechmediaserver_....._all.deb ./index.html | cut -c82-114)
echo "DOWNLOADING LMS 7.8.0"
wget http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/$download
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LMS 7.8.0 DOWNLOADED"
  else
    echo "[ ERROR ] LMS 7.8.0 DOWNLOAD FAILED"
fi
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_....._all.deb)
dpkg -i /usr/share/sadiy_files/installers/lms_stable/$install
rm /usr/share/sadiy_files/installers/lms_stable/index*
sadiy_setup
}

lms_install_7.8.x () {
cd /usr/share/sadiy_files/installers/lms_nightly/
wget http://downloads.slimdevices.com/nightly/?ver=7.8 > /dev/null 2>&1
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] INDEX RECEIVED"
  else
    echo "[ ERROR ] INDEX DOWNLOAD FAILED"
fi
download=$(grep logitechmediaserver_7.8.1~.........._all.deb ./index.html?ver=7.8 | cut -c27-85)
echo "DOWNLOADING LMS 7.8.X"
wget http://downloads.slimdevices.com/nightly/$download
exitstatus=$?
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LMS 7.8.X DOWNLOADED"
  else
    echo "[ ERROR ] LMS 7.8.X DOWNLOAD FAILED"
fi
service logitechmediaserver stop
install=$(ls | grep logitechmediaserver_7.8.1~.........._all.deb)
dpkg -i /usr/share/sadiy_files/installers/lms_nightly/$install
rm /usr/share/sadiy_files/installers/lms_nightly/index*
sadiy_setup
}

lms_install_7.9.x () {
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
wget http://downloads.slimdevices.com/nightly/$download
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
}

#------------------------------------
#MENU
#------------------------------------
menu=$(whiptail --title "$title" --menu "Install menu:" 18 60 10 \
"1" "Install stable Logitech Media Server 7.7.5" \
"2" "Install stable Logitech Media Server 7.8.0" \
"3" "Install latest nightly Logitech Media Server 7.8.X" \
"4" "Install latest nightly Logitech Media Server 7.9.X" \
"5" "Back" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]
then
	if [ $menu = 1 ]; then
  	lms_install_7.7.5 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.7.5in.log_$logname
  elif [ $menu = 2 ]; then
  	lms_install_7.8.0 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.8.0in.log_$logname
	elif [ $menu = 3 ]; then
  	lms_install_7.8.x 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.8.xin.log_$logname
  elif [ $menu = 4 ]; then
  	lms_install_7.9.x 2>&1 | tee /var/log/squeezeaudiodiy/logicms_7.9.xin.log_$logname
	elif [ $menu = 5 ]; then
  	sadiy_setup
	fi
else
	exit
fi
