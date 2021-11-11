#!/bin/bash

MegaCli -ShowSummary -a0 | grep Slot | awk '{print $8}' | while read LINE; do 
#    echo "#################################################"
#    echo "# Disk: $LINE"
#    echo "#################################################"
/megacli/check_smart.pl -d /dev/sda -i megaraid,$LINE
done
