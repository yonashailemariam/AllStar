#! /bin/sh

cd /usr/src
svn checkout http://svn.ohnosec.org/svn/projects/allstar/astsrc-1.4.23-pre/trunk astsrc-1.4.23-pre

# grab the svn version number and put it where asterisk/Makefile expects it.
cd /usr/src/astsrc-1.4.23-pre
svnversion >asterisk/.version

mkdir -p /srv/download
cd /srv/download
wget http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

# Clean out unneeded source and add dahdi source
cd /usr/src/astsrc-1.4.23-pre
rm -rf libpri
rm -rf zaptel
tar zxvf /srv/download/dahdi-linux-complete-current.tar.gz
mv dahdi-linux-complete* dahdi-linux-complete

# Get the kernel-headers for the running kernel
apt-get install linux-headers-`uname -r` -y


