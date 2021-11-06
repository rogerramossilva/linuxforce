#!/bin/bash

source /var/scripts/script03.sh

menu

until [ $OP -eq 0 ]; do

if [ $OP -eq 1 ]; then
        soma
elif [ $OP -eq 2 ]; then
        sub
elif [ $OP -eq 0 ]; then
        exit
else
        echo "Digite uma opção valida"
fi

read -p "Pressione Enter para Continuar"

clear

menu

done
