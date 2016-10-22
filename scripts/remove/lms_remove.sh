#!/bin/bash
title=$(cat /usr/share/sadiy_files/setup/version)

apt-get remove --purge logitechmediaserver
sadiy_setup
