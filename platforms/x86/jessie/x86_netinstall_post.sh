#!/bin/sh

# DL firstboot script and put in in /usr/local/bin
wget https://github.com/N4IRS/AllStar/raw/master/platforms/x86/jessie/x86_netinstall_allstar_asterisk_install.sh -O /srv/x86_netinstall_allstar_asterisk_install.sh
# DL firstboot rc.local patch and put in in /tmp
wget https://github.com/N4IRS/AllStar/raw/master/patches/patch-x86-first-netinstall-rc.local -O /tmp/patch-x86-first-netinstall-rc.local
# make the script executable
chmod +x /srv/x86_netinstall_allstar_asterisk_install.sh

# modify rc.local to run firstboot
cd /etc
patch </tmp/patch-x86-first-netinstall-rc.local
echo "rc.local modified to run x86_netinstall_allstar_asterisk_install.sh" >>/var/log/automated_install


