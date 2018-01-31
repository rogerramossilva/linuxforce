#!/bin/bash

# Variavel com listagem de usuarios inseridos no Samba
LUSER="$(samba-tool user list | egrep -v 'Administrator|Guest|krbtgt')"

for LSUSER in $LUSER
    do 
        # Variavel com listagem de SIDS de usarios do AD
        SID="$(wbinfo -n $LSUSER | awk -F" " '{print $1}')"
        # Variavel com UID de usuarios da base Unix
        ID="$(getent passwd $LSUSER | awk -F: '{print $3}')"
        # Converte SID para UID nos usuarios do AD
        wbinfo -S $SID >> /dev/null
        # Cria arquivo ldif temporario
        > /tmp/modify.ldif
        echo "dn: CN=$SID" >> /tmp/modify.ldif
        echo "changetype: modify" >> /tmp/modify.ldif
        echo "replace: xidNumber" >> /tmp/modify.ldif
        echo "xidNumber: $ID" >> /tmp/modify.ldif
        echo "" >> /tmp/modify.ldif
        # Modificacao do mapeamento de UIDS via modify.ldif
        ldbmodify -H /opt/samba/private/idmap.ldb /tmp/modify.ldif
done
