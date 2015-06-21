#! /bin/sh

#########################################################
#                                                       #
# script was built for rpi1 AllStar Asterisk install.   #
#                                                       #
#########################################################

echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

/srv/scripts/required_libs.sh
/srv/scripts/build_tools.sh
/srv/scripts/get_src.sh

/srv/scripts/build_dahdi.sh
/srv/scripts/build_asterisk.sh

cp /platforms/rpi/rpi2_wheezy/rc.local /etc
