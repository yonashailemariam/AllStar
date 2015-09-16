#!/bin/sh

sleep 10

# get AllSter, DAHDI and kernel headers
/srv/scripts/get_src.sh
echo "Get Source" >>/var/log/install.log

# build DAHDI
/srv/scripts/build_dahdi.sh
echo "build DAHDI" >>/var/log/install.log

# Build Asterisk
/srv/scripts/build_asterisk.sh
echo "build Asterisk" >>/var/log/install.log

# make /dev/dsp available
# not needed for a hub
# Though it will not hurt anything.
echo snd_pcm_oss >>/etc/modules

# start update node list on boot
cd /etc
patch < /srv/patches/patch-rc.local

# Reboot into the system
echo "AllStar Asterisk install Complete, rebooting" >>/var/log/install.log

sleep 5

/sbin/reboot

