#!/bin/bash

#------------------------------------
#ENSURE RUNNING AS ROOT
#------------------------------------
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

chmod +x ./scripts/squeeze_install.sh
./scripts/squeeze_install.sh
