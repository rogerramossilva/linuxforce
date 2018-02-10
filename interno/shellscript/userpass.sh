#!/bin/bash

clear

USER=`getent passwd | awk -F: '$3 >= 1000 || $3 == 0 {print $1}' | egrep -v 'nobody|nogroup'`

for I in $USER
    do
        echo "O usuario $I esta no sistema"
        ACTV=`chage -l $I | grep inativa | awk -F" " '{print $4}'`
        PASS=`getent passwd $I | awk -F: '{print $2}'`
        SHAD=`getent shadow $I | awk -F: '{print $2}'`
        if [ $ACTV == 'nunca' ] && [ $PASS == 'x' ] 
            then
                echo "Sua senha nunca expira"
                BLOQ=`echo $SHAD | egrep ^'!'`
                if [ $BLOQ ]
                    then
                        echo -e "Sua senha esta bloqueada em /etc/shadow\n"
                else
                    echo -e "O usuário esta liberado para autenticar\n"
                fi
        else
            echo "Sua senha expira em $ACTV"
                if [ $PASS == '!x' ]
                    then
                        echo -e "Sua autenticação esta bloqueada em /etc/passwd\n"
                fi
        fi
done
