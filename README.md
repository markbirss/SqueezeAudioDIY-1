SqueezeAudioDIY 1.3 Alpha
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
  - Latest nightly Logitech Media Server v7.9.x

- Squeezelite audio device:
  - View audio devices in detail
  - Change the default audio device

- Squeezelite options:
  - View Squeezelite settings
  - Set name of the Squeezelite player
  - Set extra arguments to Squeezelite
  - Deactivate extra arguments in configuration file
  - Point Squeezelite to your Server via IPv4
  - Deactivate custom server IPv4 address in configuration file

- View logs
  - Installer logs
  - Squeezelite watch log (when listening)
  - Squeezelite static log

- Fixes for I2S use:
 - Armbian - Orange Pi Single Board Computers
 - Raspbian - Raspberry Pi Singe Board Computers
 - Raspbian - Hifiberry Products

Notes:
------
- Logitech Media Server v7.7.5 does not work on Ubuntu 16.04+

Resources:
------------
- Squeezelite is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git
- Squeezebox stable v7.7.5 (Released 27-Nov-2014) based on the stable build available at http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/
- Sqeezebox nightly v7.9.x is based on the nightly build available at http://downloads.slimdevices.com/nightly/?ver=7.9
