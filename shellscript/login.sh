#!/bin/bash

clear

echo -e "\nEnter username:\n"
read NOME
echo ''

USER=`w | awk -F" " '{print $1}' | grep $NOME | uniq`

until $USER &>> /dev/null
    do
        HORA=`date | cut -d' ' -f4`
        echo "User $USER connected - $HORA"
        sleep 1.0
        USER=`w | awk -F" " '{print $1}' | grep $NOME | uniq`
done

echo ''
