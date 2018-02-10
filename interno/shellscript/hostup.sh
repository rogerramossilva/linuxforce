#!/bin/bash

clear

echo -e "\nInsert host IP or FQDN:\n"

read IPHOST
echo ''

COUNT=1

while ping -c1 $IPHOST &>> /dev/null
    do
        echo "ICMP $COUNT – Host $IPHOST ICMP ON"
        sleep 1.0
        let COUNT++
done
