#!/bin/bash

# This script decrypt a password hash using the software John the Ripper, 
# its a example for use the conditional structure ( if ) and an a ( for ) 
# loop in Shell Script lessons. 

# Este script decripta um hash de senha usando o software John the Ripper
# , é um exemplo de utilizacão para a estrutura condicional (if) e um loop
# (for) em aulas de Shell Script.

LIST=`awk -F: '$3 >= 1000 || $3 == 0 {print $1}' /etc/passwd | egrep -v 'nobody|nogroup'`
WORD='/srv/asf/security/john/run/password.lst'
JOHN='/srv/asf/security/john/run/john'
SPAWN='/tmp/john'

mkdir -p $SPAWN

> $SPAWN/passwords.txt
> $SPAWN/results.txt

if [ $JOHN ]
    then
        for I in $LIST ; do
            USER=`getent shadow $I`
            echo $USER >> $SPAWN/passwords.txt
    done
fi    

$JOHN --wordlist=$WORD $SPAWN/passwords.txt &>> $SPAWN/results.txt &
