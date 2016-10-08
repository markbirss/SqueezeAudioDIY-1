SqueezeAudioDIY 1.3
=========================
These are terminal based utilities to install and manage Squeezelite

Requirements:
-------------
- Debian Jessie or higher
- Ubuntu 14.04 or higher

Supported Architecture:
-----------------------
- i386
- x86_64
- ARM

Features:
---------
- Install Squeezelite v1.8.5-802
- Install latest version of Squeezelite
- Install stable Logitech Media Server v7.7.5
- Install latest nightly Logitech Media Server v7.9
- View audio devices in detail
- Change the default audio device
- Set default options for Squeezelite
  - Set name of the Squeezelite player
- View logs of installers
- Board fixes for I2S use
 - Orange Pi
 - Raspberry Pi

Notes:
------
- Logitech Media Server v7.7.5 does not work on Ubuntu 16.04+

Squeezelite v1.8.5-802 Setup for Debian-Based-Distro:
-----------------------------------------------------
```shell
cd SqueezeAudioDIY
./setup.sh
```

To Access Menu After Installation:
----------------------------------
```shell
squeeze_setup
```

Squeezelite:
------------
Is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git

Squeezebox Stable v7.7.5 (Released 27-Nov-2014):
-----------------------------------------------
Is based on the stable build available on http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/

Squeezebox Nightly v7.9:
------------------------
Is based on the nightly build available on http://downloads.slimdevices.com/nightly/?ver=7.9
