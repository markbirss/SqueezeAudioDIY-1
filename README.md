squeezelite_autoinstall
==============
I'm new to programming and this is my first attempt at it.
This is just a personal project in exploring programming with my hobbies.

This script compiles the latest version of Squeezelite and installs it on Debian based distros. 
Additionally it adds a few tools on your system for Squeezelite.

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
chmod +x ./squeezelite_install.sh
sudo ./squeezelite_install.sh
```

Tools for Squeezelite
---------------------
Select default audio device:
```shell
sudo squeeze_audio
```
Select name for Squeezelite Player:
```shell
sudo squeeze_name
```
Update Squeezelite:
```shell
sudo squeeze_update
```
Raspberry Pi - HifiBerry Script
```shell
chmod +x ./squeeze_rpi_hifiberry.sh
sudo ./squeeze_rpi_hifiberry.sh
```
Squeezelite:
------------
Is based on the project of Ralph Irving here at github https://github.com/ralph-irving/squeezelite.git
