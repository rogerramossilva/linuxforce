#!/bin/bash

HORA=`date | cut -d' ' -f4`
TIME=`uptime | awk -F" " '{print $3}' | sed -e s'|,||g'`
USERS=`uptime | awk -F" " '{print $4}'`

clear
echo -e "\nSet a option for info:\n"
echo 'System time            [ 1 ]'
echo 'Uptime                 [ 2 ]'
echo 'Users authenticated    [ 3 ]'
echo -e "Exit                   [ 4 ]\n"
read OPT

case $OPT in
    1)
      echo -e "\nSystem time: $HORA\n"
    ;;
    2)
      echo -e "\nUptime: $TIME\n"
    ;;
    3)
      echo -e "\nUsers authenticated: $USERS\n"
    ;;
    4)
      echo -e "\nExit\n"
    ;;
    *)
      echo -e "\nInvalid option\n"
    ;;
esac
