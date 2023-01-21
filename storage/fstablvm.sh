#!/bin/bash

for i in drivers infrastructure lixeiras manager marketing owner profiles public security devel homes; do echo -e "/dev/storage/$i \t\t /srv/asf/samba/$i \t\t ext4  defaults 0 0"  >> /etc/fstab; done
