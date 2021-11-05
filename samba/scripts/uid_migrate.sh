#!/bin/bash

# Variavel com listagem de usuarios inseridos no Samba
list="$(samba-tool user list | egrep -v 'Administrator|Guest|krbtgt')"

for LSUSER in $list
    do 
        # Variavel com listagem de SIDS de usarios do AD
        sid="$(wbinfo -n $LSUSER | awk -F" " '{print $1}')"

        # Variavel com UID de usuarios da base Unix
        ids="$(getent passwd $LSUSER | awk -F: '{print $3}')"
        
	# Converte SID para UID nos usuarios do AD
        wbinfo -S $sid >> /dev/null
		
	# Cria arquivo ldif temporario
        > /tmp/modify.ldif
        
	# Preenche o arquivo temporario com os novos dados
	echo "dn: CN=$sid" >> /tmp/modify.ldif
        echo "changetype: modify" >> /tmp/modify.ldif
        echo "replace: xidNumber" >> /tmp/modify.ldif
        echo "xidNumber: $ids" >> /tmp/modify.ldif
        echo "" >> /tmp/modify.ldif

        # Modificacao do mapeamento de UIDS via modify.ldif
        ldbmodify -H /var/lib/samba/private/idmap.ldb /tmp/modify.ldif
done
