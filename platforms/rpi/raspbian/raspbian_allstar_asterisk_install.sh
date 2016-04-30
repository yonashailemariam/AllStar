#!/bin/sh -e

# install required
/srv/scripts/required_libs.sh

# install libi2c-dev
apt-get install libi2c-dev -y

# install build_tools
/srv/scripts/build_tools.sh

# get AllSter, DAHDI and kernel headers
/srv/scripts/get_src.sh

# build DAHDI
/srv/scripts/build_dahdi.sh

# build libpri
/srv/scripts/build_libpri.sh

# Build Asterisk

# # # modify for systemd support

/srv/scripts/build_asterisk.sh

# make /dev/dsp available
# not needed for a hub
# Though it will not hurt anything.
echo snd_pcm_oss >>/etc/modules

# Add asterisk to logrotate
/srv/scripts/mk_logrotate_asterisk.sh

# setup for Phase 3
cp /srv/post_install/* /usr/local/sbin

# # # Add SayIP

# Start asterisk on boot
systemctl enable asterisk.service

# Run updatenodelist after asterisk has started
systemctl enable updatenodelist.service

touch /etc/asterisk/firsttime

echo "test -e /etc/asterisk/firsttime && /usr/local/sbin/firsttime" >>/root/.bashrc

echo "Please reboot now"
