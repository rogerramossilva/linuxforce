#!/bin/bash

# Array com grupos do Samba
smb_groups=('infrastructure' 'security' 'public' 'manager' 'marketing' 'owner')

for grupos in ${smb_groups[@]}
    do 
        # Variavel com listagem de SIDS de usarios do AD
        XID=`wbinfo --group-info=$grupos | cut -d: -f3`
	echo $XID
#
#        # Variavel com UID de usuarios da base Unix
#        ID="$(getent passwd $LSUSER | awk -F: '{print $3}')"
#        
#	# Converte SID para UID nos usuarios do AD
#        wbinfo -S $SID >> /dev/null
#		
	# Cria arquivo ldif temporario
 #       > /tmp/modify.ldif
        
	# Preenche o arquivo temporario com os novos dados
#	echo "dn: CN=$SID" >> /tmp/modify.ldif
 #       echo "changetype: modify" >> /tmp/modify.ldif
 #       echo "replace: xidNumber" >> /tmp/modify.ldif
 #       echo "xidNumber: $ID" >> /tmp/modify.ldif
 #       echo "" >> /tmp/modify.ldif

        # Modificacao do mapeamento de UIDS via modify.ldif
       # ldbmodify -H /var/lib/samba/private/idmap.ldb /tmp/modify.ldif
done
