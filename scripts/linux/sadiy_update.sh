#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

if (whiptail --title "$title" --yes-button "Update" --no-button "Back" --yesno "Are you sure you want to update latest SqueezeAudioDIY? (Warning! This update may contain unstable release)" 18 60) then
  cd /tmp
  rm -R /tmp/SqueezeAudioDIY > /dev/null 2>&1
  git clone https://github.com/coenraadhuman/SqueezeAudioDIY.git
  cd SqueezeAudioDIY
  ./setup.sh
else
  sadiy_setup
fi
