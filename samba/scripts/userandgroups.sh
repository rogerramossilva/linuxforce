#!/bin/bash

# Array com grupos de sistema
all_groups=('infrastructure' 'security' 'public' 'manager' 'marketing' 'owner' 'devel')
for group in ${all_groups[@]}; do
	groupadd $group      
done

# Array com Users de sistema
all_users=('gideon.goddard' 'elliot.alderson' 'lloyd.chung' 'angela.moss' 'ollie.parker')
for users in ${all_users[@]}; do
	useradd -m -k /etc/skel -d /srv/asf/samba/homes/$users -s /bin/bash  $users      
done
