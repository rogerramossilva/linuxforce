#!/bin/bash

source /var/scripts/script03.sh

menu

while [ $OP -ne 0 ]; do

case $OP in 
        1|01)
                soma
                ;;
        2|02)
                sub
                ;;
        0|00)
                exit
                ;;
        *)
                echo "Opção invalida "
                ;;
esac

read -p "Pressione Enter para Continuar"
#sleep 5
clear
menu
done
