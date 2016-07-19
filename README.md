squeeze_install_scripts
==============
I'm new to programming and this is my first attempt at it.
This is just a personal project in exploring programming with my hobbies.

These scripts download the latest version of the respective programs and install them on Debian based distros.

Obtaining Scripts
-----------------
```shell
sudo apt-get install git
git clone https://github.com/ictinus2310/squeeze_install_scripts.git
cd squeeze_install_scripts
```
Squeezelite Setup for Debian-Based-Distro
-----------------------------------------
```shell
sudo sh yourdirectory/squeeze_install_scripts/squeezelite.sh
```
Logitech Media Server v7.9 Setup for Debian-Based-Distro
--------------------------------------------------------
AMD64 Architecture:
```shell
sh yourdirectory/squeeze_install_scripts/lms_amd64_install.sh
```
i386 Architecture:
```shell
sh yourdirectory/squeeze_install_scripts/lms_i386_install.sh
```
ARM Architecture:
```shell
sh yourdirectory/squeeze_install_scripts/lms_arm_install.sh
```

Squeezebox Nightly v7.9:
-------------------
Is based on the nightly build available on http://downloads.slimdevices.com/nightly/?ver=7.9

Squeezelite:
------------
Is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git
