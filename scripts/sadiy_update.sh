#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

if (whiptail --title "$title" --yes-button "Yes" --no-button "Back" --yesno "Are you sure you want to update SqueezeAudioDIY?" 10 60) then
  cd /tmp
  rm -R /tmp/SqueezeAudioDIY
  git clone https://github.com/coenraadhuman/SqueezeAudioDIY.git
  cd SqueezeAudioDIY
  ./setup.sh
else
  sadiy_setup
fi
