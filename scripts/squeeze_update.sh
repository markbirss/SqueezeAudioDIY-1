#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop
echo "Stopped Squeezelite."

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/Squeezelite/squeezelite
echo "Old Squeezelite removed."

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
echo "Compiling latest Squeezelite:"
cd /usr/bin/squeeze_files/
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/squeeze_files/queezelite
OPTS="-DDSD -DRESAMPLER" make

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
echo "Started Squeezelite."
exit
