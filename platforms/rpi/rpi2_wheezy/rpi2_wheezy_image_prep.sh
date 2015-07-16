#! /bin/sh

# change governor to performance
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# set the locales and time zone
dpkg-reconfigure locales
dpkg-reconfigure tzdata

# keep raspberrypi-bootloader at current version.
# Don't let it upgrade the kernel.
echo "raspberrypi-bootloader hold" | dpkg --set-selections

# Make sure we are running the latest and greatest
apt-get update -y
# apt-get purge --auto-remove 'libx11-.*'
apt-get dist-upgrade -y

# Add re-generate SSL keys <--------------------------------

# Install 3.18  kernel and matching headers
apt-get install linux-image-3.18.0-trunk-rpi2 -y
apt-get install linux-headers-3.18.0-trunk-rpi2 -y

# add to /boot/config.txt
mount /dev/mmcblk0p1 /boot
cd /boot
patch < /srv/patches/patch-rpi2-3-18-config.txt

echo "REBOOT before you run the install script"


