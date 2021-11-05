#!/bin/bash

list=`samba-tool user list | egrep -v 'Administrator|krbtgt|Guest'`

for users in $list
    do
        mkdir -p /srv/asf/samba/lixeiras/$users
	chown $users:$users /srv/asf/samba/lixeiras/$users
	chmod 777 /srv/asf/samba/lixeiras/$users
done
