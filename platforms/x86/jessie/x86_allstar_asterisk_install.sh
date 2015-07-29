#! /bin/sh

#########################################################
#                                                       #
# script was built for x86 AllStar Asterisk install.    #
#                                                       #
#########################################################

timedatectl set-ntp true

/srv/scripts/required_libs.sh
/srv/scripts/build_tools.sh
/srv/scripts/get_src.sh

/srv/scripts/build_dahdi.sh
/srv/scripts/build_asterisk.sh

