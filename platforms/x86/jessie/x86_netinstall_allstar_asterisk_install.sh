#!/bin/sh -e

# This script will run the first time the system boots. Even
# though we've told it to run after networking is enabled,
# I've observed inconsistent behavior if we start hitting the
# net immediately.
#
# Introducing a brief sleep makes things work right all the
# time.
sleep 30

# setup ntp
timedatectl set-ntp true

# DL x86 script
echo "start DL of AllStar Asterisk install" >>/var/log/automated_install
cd /srv
wget https://github.com/N4IRS/AllStar/raw/master/x86.tar.gz

# untar x86 script
tar zxvf x86.tar.gz
cd /etc
patch </srv/patches/patch-x86-stock-netinstall-rc.local
echo "put rc.local back to default" >>/var/log/automated_install

# run x86_allstar_install
# need to tweak this for required libs and build tools are not run

/srv/scripts/get_src.sh
echo "Get Source" >>/var/log/automated_install

/srv/scripts/build_dahdi.sh
echo "build DAHDI" >>/var/log/automated_install

/srv/scripts/build_asterisk.sh
echo "build Asterisk" >>/var/log/automated_install

# moved steps below from build_asterisk to platform install file

# make /dev/dsp available
# not needed for a hub
# Though it will not hurt anything.
echo snd_pcm_oss >>/etc/modules

# start update node list on boot
cd /etc
patch < /srv/patches/patch-rc.local

# Reboot into the system
echo "AllStar Asterisk install Complete, rebooting" >>/var/log/automated_install

sleep 5

/sbin/reboot

