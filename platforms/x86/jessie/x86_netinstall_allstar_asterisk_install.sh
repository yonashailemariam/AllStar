#!/bin/sh -e

# This script will run the first time the system boots. Even
# though we've told it to run after networking is enabled,
# I've observed inconsistent behavior if we start hitting the
# net immediately.
#
# Introducing a brief sleep makes things work right all the
# time. This needs to be checked again and see if we can remove it.

# Disable /etc/network/interfaces
cd /etc/network
patch < /srv/patches/patch-interfaces
echo "Disable /etc/network/interfaces" >>/var/log/automated_install

# Setup systemd networking
/srv/scripts/mk_eth0.network.sh
echo "make systemd network" >>/var/log/automated_install

# Enable and start systemd networking
systemctl enable systemd-networkd.service
systemctl start systemd-networkd.service

sleep 10

# Log UDP and TCP listeners during install process
echo > /var/log/netstat.txt
echo "At the top of the script" >> /var/log/netstat.txt
echo  >> /var/log/netstat.txt
netstat -unap >> /var/log/netstat.txt
netstat -tnap >> /var/log/netstat.txt

# DL x86 tar ball
echo "start DL of AllStar Asterisk install" >>/var/log/automated_install
cd /srv
wget https://github.com/N4IRS/AllStar/raw/master/x86.tar.gz

# untar x86 script
tar zxvf x86.tar.gz

########################################################

# Moved to image prep

# stop sshd from listening to ipv6
# cd  /etc/ssh
# patch </srv/patches/patch-sshd_config
# service ssh restart
# echo "removed sshd ipv6 listener" >>/var/log/automated_install

# disable exim4 daemon
# cd /etc/default/
# patch </srv/patches/patch-exim4
# service exim4 restart
# echo "disable exim4 daemon" >>/var/log/automated_install

##########################################################

# No need for NFS
apt-get remove nfs-common -y
apt-get purge rpcbind -y
apt-get autoremove -y
echo "removed NFS" >>/var/log/automated_install

# setup ntp
apt-get install ntpdate -y

# put rc.local back to default
cd /etc
patch </srv/patches/patch-x86-stock-netinstall-rc.local
echo "put rc.local back to default" >>/var/log/automated_install

# Get AllSter, DAHDI and kernel headers
/srv/scripts/get_src.sh
echo "Get Source" >>/var/log/automated_install

# build DAHDI
/srv/scripts/build_dahdi.sh
echo "build DAHDI" >>/var/log/automated_install

# Build Asterisk
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

# Disable /etc/network/interfaces
# cd /etc/network
# patch < /srv/patches/patch-interfaces
# echo "Disable /etc/network/interfaces" >>/var/log/automated_install

# Setup systemd networking
# /srv/scripts/mk_eth0.network.sh
# echo "make systemd network" >>/var/log/automated_install

# Enable and start systemd networking
# systemctl enable systemd-networkd.service
# systemctl start systemd-networkd.service

# Reboot into the system
echo "AllStar Asterisk install Complete, rebooting" >>/var/log/automated_install

sleep 5

/sbin/reboot

