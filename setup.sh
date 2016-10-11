#!/bin/bash

#LOG FILE NAME
logname=$(date +"%Y%m%d.%H%M%S")

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

./scripts/installers/squeeze_install.sh 2>&1 | tee ./squeeze_install.log_$logname
mv ./squeeze_install.log_$logname /var/log/squeezeaudiodiy/
