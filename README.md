squeezelite_autoinstall
==============
I'm new to programming and this is my first attempt at it.
This is just a personal project in exploring programming with my hobbies.

These scripts download the latest version of the respective programs and install them on Debian based distros.

Obtaining Scripts
-----------------
```shell
sudo apt-get install git
git clone https://github.com/ictinus2310/squeezelite_autoinstall.git
cd squeezelite_autoinstall
```
Squeezelite Setup for Debian-Based-Distro
-----------------------------------------
```shell
sudo sh ./squeezelite_install.sh
```
Logitech Media Server v7.9 Setup for Debian-Based-Distro
--------------------------------------------------------
AMD64 Architecture:
```shell
sh ./lms_amd64_install.sh
```
i386 Architecture:
```shell
sh ./lms_i386_install.sh
```
ARM Architecture:
```shell
sh ./lms_arm_install.sh
```
Tools for Squeezelite
---------------------
Select default audio device:
```shell
sh ./audio_select.sh
```

Squeezebox Nightly v7.9:
-------------------
Is based on the nightly build available on http://downloads.slimdevices.com/nightly/?ver=7.9

Squeezelite:
------------
Is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git
