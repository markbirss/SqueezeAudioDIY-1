#!/bin/bash
title=$(cat /usr/share/squeeze_files/setup/version)

watch tail -n 20 /usr/share/squeeze_files/logs/squeeze/squeezelite.log
