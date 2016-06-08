#! /bin/sh

#################################################
#                                               #
# Patch asterisk for AllStar Asterisk           #
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


