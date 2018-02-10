#!/bin/bash

USERS=`getent passwd | awk -F: '$3 >= 1000 {print $1}' | egrep -v nobody`

for ONE in $USERS ; do
    HM=`getent passwd $ONE | awk -F: '{print $6}'`
    echo "Usuario $ONE encontrado"
    maildirmake $HM/Maildir 2> /dev/null
    echo "Diretorio $HM/Maildir criado com exito"
    maildirmake $HM/Maildir/.Enviados 2> /dev/null
    echo "Diretorio $HM/Maildir/.Enviados criado com exito"
    maildirmake $HM/Maildir/.Rascunhos 2> /dev/null
    echo "Diretorio $HM/Maildir/.Rascunhos criado com exito"
    maildirmake $HM/Maildir/.Lixeira 2> /dev/null
    echo "Diretorio $HM/Maildir/.Lixeira criado com exito"
    maildirmake $HM/Maildir/.Spam 2> /dev/null
    echo "Diretorio $HM/Maildir/.Spam criado com exito"
    chown $ONE:$ONE -R $HM/Maildir 2> /dev/null
    echo "Permissoes de $ONE:$ONE definidas recursivamente para $HM/Maildir"
done
