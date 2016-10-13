#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

watch tail -n 20 /var/log/squeezeaudiodiy/squeezelite.log
