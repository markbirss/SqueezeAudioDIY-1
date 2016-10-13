#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

apt-get remove --purge squeezelite
sadiy_setup
