#!/bin/bash

#------------------------------------
#STOP SQUEEZELITE
#------------------------------------
service squeezelite stop

#------------------------------------
#DIRECTORIES
#------------------------------------
rm -R /usr/bin/squeeze_files/squeezelite

#------------------------------------
#COMPILE LATEST SQUEEZELITE
#------------------------------------
cd /usr/bin/squeeze_files/
git clone https://github.com/ralph-irving/squeezelite.git
cd /usr/bin/squeeze_files/squeezelite
OPTS="-DDSD -DRESAMPLE -DALSA" make
if [ $exitstatus = 0 ]
  then
    echo "[ OK ] LATEST SQUEEZELITE COMPILED"
  else
    echo "[ ERROR ] LATEST SQUEEZELITE COMPILING FAILED"
fi

#------------------------------------
#START SQUEEZELITE
#------------------------------------
service squeezelite start
exit
