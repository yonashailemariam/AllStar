#! /bin/sh

##############################################
#                                            #
# Patch and build dahdi for AllStar Asterisk #
#                                            #
##############################################

# this needs to be fixed so that if the version changes so does the cd
cd /usr/src/astsrc-1.4.23-pre/dahdi-linux-complete/

# Patch dahdi for use with AllStar Asterisk
# https://allstarlink.org/dude-dahdi-2.10.0.1-patches-20150306
# Soon to be included in the official release of DAHDI from Digium.
patch -p1 < /srv/patches/patch-dahdi-dude-current

# remove setting the owner to asterisk
patch -p0 < /srv/patches/patch-dahdi.rules

# Build and install dahdi
make all
make install
make config

# Dont need and dahdi hardware drivers loaded for most installs
mv /etc/dahdi/modules /etc/dahdi/modules.old



