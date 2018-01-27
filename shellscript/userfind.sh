#!/bin/bash

clear

echo -e "\nFind user:\n"
read NUSER

UFIND=`getent passwd $NUSER`

if [ $UFIND ] ; then
    echo -e "\nThe user $NUSER exists.\n"
    echo -e "More information about $NUSER:\n"
    id $NUSER && echo ''
    chage -l $NUSER && echo ''
else
    echo -e "\nThe user $NUSER not exists.\n"
fi
