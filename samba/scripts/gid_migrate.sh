#!/bin/bash

# Array com grupos do Samba
smb_groups=('infrastructure' 'security' 'public' 'manager' 'marketing' 'owner')

for grupos in ${smb_groups[@]}
    do 
        # Variavel com listagem de SIDS de usarios do AD
        xid=`wbinfo --group-info=$grupos | cut -d: -f3`

	# Converte XID para GID nos usuarios do AD
        sid=`wbinfo -G $xid`
        
	# Variavel com UID de usuarios da base Unix
        gid=`getent group $grupos | cut -d: -f3`
		
	# Cria arquivo ldif temporario
        > /tmp/modify.ldif
        
	# Preenche o arquivo temporario com os novos dados
	echo "dn: CN=$sid" >> /tmp/modify.ldif
        echo "changetype: modify" >> /tmp/modify.ldif
        echo "replace: xidNumber" >> /tmp/modify.ldif
        echo "xidNumber: $gid" >> /tmp/modify.ldif
        echo "" >> /tmp/modify.ldif

        # Modificacao do mapeamento de UIDS via modify.ldif
        ldbmodify -H /var/lib/samba/private/idmap.ldb /tmp/modify.ldif
done
