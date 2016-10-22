SqueezeAudioDIY 1.4 Beta
=========================
This is not a stable version, please use version 1.2.1 found in releases:
https://github.com/coenraadhuman/SqueezeAudioDIY/releases/tag/1.2.1

These are terminal based utilities to install and manage Squeezelite

Requirements:
-------------
- Debian Jessie or higher
- Ubuntu 16.04 or higher

Supported Architecture:
-----------------------
- i386
- x86_64
- ARM

To Install:
-----------------------------------------------------
```shell
git clone https://github.com/coenraadhuman/SqueezeAudioDIY.git
cd SqueezeAudioDIY
./setup.sh
```

To Access Setup After Installation:
----------------------------------
```shell
sadiy_setup
```

Features:
---------
- Installers:
  - Squeezelite v1.8.5-802
  - Latest version of Squeezelite
  - Stable Logitech Media Server v7.7.5
  - Stable Logitech Media Server v7.8.0
  - Latest nightly Logitech Media Server v7.8.x
  - Latest nightly Logitech Media Server v7.9.x

- Squeezelite options:
  - View audio devices in detail
  - Change the default audio device
  - View Squeezelite settings
  - Set name of the Squeezelite player
  - Set extra arguments to Squeezelite
  - Deactivate extra arguments in configuration file
  - Point Squeezelite to your Server via IPv4
  - Deactivate custom server IPv4 address in configuration file

- Logitech Media Server options:
  - Create permanent mount point in fstab for use with LMS (still in development)

- View logs
  - Installer logs
  - Squeezelite dynamic log
  - Squeezelite static log

Notes:
------
- Logitech Media Server v7.7.5 does not work on Ubuntu 16.04+

Resources:
------------
- Squeezelite is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git
- All Squeezebox installation are based on install files available on http://downloads.slimdevices.com/
