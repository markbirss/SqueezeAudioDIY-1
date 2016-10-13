#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

watch tail -n 20 /var/log/squeezeaudiodiy/squeezelite.log
