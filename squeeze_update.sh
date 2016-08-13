#!/bin/bash

#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
        echo "Running as root."
else
        echo "Run script as root."
        exit
fi

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /Squeezelite/squeezelite
echo "Old files removed."

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
echo "Compiling latest Squeezelite:"
cd /Squeezelite
git clone https://github.com/ralph-irving/squeezelite.git
cd /Squeezelite/squeezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."
exit
