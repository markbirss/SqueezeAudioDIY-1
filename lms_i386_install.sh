#!/bin/bash

#------------------------------------
#DIRECTORY
#------------------------------------
directory=$(ls | grep old_files)
if [ $directory = old_files ]
then
	echo Running.
else
	mkdir old_files
fi

#------------------------------------
#GET SITE INFORMATION
#------------------------------------
wget http://downloads.slimdevices.com/nightly/?ver=7.9

#------------------------------------
#COMPARE VERSIONS & INSTALL PACKAGE
#------------------------------------
newfile=$(grep logitechmediaserver_7.9.0~.........._i386.deb ./index.html?ver=7.9 | cut -c42-86)
oldfile=$(ls | grep logitechmediaserver_7.9.0~.........._i386.deb)

if [ $newfile = $oldfile ]
then
	echo There is NO new version available.
	rm ./index*
	exit
else
	echo There is a NEW version available.
	mv ./$oldfile ./old_files/
	download=$(grep logitechmediaserver_7.9.0~.........._i386.deb ./index.html?ver=7.9 | cut -c27-86)
	wget http://downloads.slimdevices.com/nightly/$download
	sudo su
	read
	service logitechmediaserver stop
	install=$(ls | grep logitechmediaserver_7.9.0~.........._i386.deb)
	dpkg -i $install
	service logitechmediaserver start
	echo Done.
	rm ./index*
	exit
fi
