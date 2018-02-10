#!/bin/bash

clear

echo -e "\nEnter the e-mail:\n"

read EMAIL
echo ''

DATA=`date +%Y-%m-%d`

for I in passwd shadow group 
    do
        INFO=`getent $I`
        echo -e "\n$INFO\n" | mail -s "$HOSTNAME-$DATA $I" $EMAIL
done
