#! /bin/sh

#################################################
#                                               #
# Patch and build asterisk for AllStar Asterisk #
#                                               #
#################################################

cd /usr/src/astsrc-1.4.23-pre/asterisk/

# patch for ulaw Core and Extras Sound Packages
patch < /srv/patches/patch-asterisk-menuselect.makeopts

# patch for SSL used in res_crypto
patch < /srv/patches/patch-configure
patch < /srv/patches/patch-configure.ac

# patch for LSB used in Debian init scripts
patch -p1 < /srv/patches/patch-rc-debian
patch < /srv/patches/patch-asterisk-makefile

./configure

# Build and install Asterisk
make
make install
make samples
make config

# Clean out and replace samples
cd /etc/asterisk/
rm *
cp /srv/configs/* .

# add the sound files for app_rpt
cd /usr/src/astsrc-1.4.23-pre
mkdir -p /var/lib/asterisk/sounds/rpt
cp -a /usr/src/astsrc-1.4.23-pre/sounds/* /var/lib/asterisk/sounds

# Install Nodelist updater
cp /usr/src/astsrc-1.4.23-pre/allstar/rc.updatenodelist /usr/local/bin/rc.updatenodelist

##########################################################################################

# move steps below to platform  install file

# cd /etc
# patch < /srv/patches/patch-rc.local

# make /dev/dsp available
# not needed for a hub
# Though it will not hurt anything.
# echo snd_pcm_oss >>/etc/modules

# echo " If all looks good, edit iax.conf extensions.conf and rpt.conf"
# echo " Pay attention to the top of rpt.conf"

