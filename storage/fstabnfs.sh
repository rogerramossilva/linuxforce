#!/bin/bash

for i in drivers infrastructure lixeiras manager marketing owner profiles public security devel homes; do 
mkdir -pv /srv/asf/samba/$i; 
echo "192.168.1.30:/srv/asf/samba/$i /srv/asf/samba/$i nfs defaults 0 0 " >> /etc/fstab ; 
chmod a+w /srv/asf/samba/$i
done
