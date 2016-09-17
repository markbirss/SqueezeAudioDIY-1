#!/bin/bash
#------------------------------------
#PERMISSIONS REQUIRED
#------------------------------------
permissions=$(whoami)
if [ $permissions = root ]
then
	echo "[ OK ] RUNNING AS ROOT"
else
  echo "[ ERROR ] RUN SCRIPT AS ROOT"
  exit
fi

chmod +x ./scripts/squeeze_install.sh
./scripts/squeeze_install.sh
