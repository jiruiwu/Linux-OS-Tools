#!/bin/bash
# Program:
#     List S.M.A.R.T status of all List all storage(SATA/SAS/NVMe).
#
# History:
# 2024/08/21    Gary Wu release, 001 version.
#
# Note:
# install the smartctl package first! (apt-get install smartctl)

chk_root()
{
if [ ! $(id -u) = 0 ]; then
	echo "Please run as root first!""Or running with sudo."
	exit
fi
}
chk_root

for drive in /dev/sd[a-z] /dev/sd[a-z][a-z]
do
   if [[ ! -e $drive ]]; then continue ; fi
   echo -n "$drive "
   smart=$(
      smartctl -H $drive 2>/dev/null |
      grep '^SMART'
   )
   [[ "$smart" == "" ]] && smart='unavailable'
   echo "$smart"
done
