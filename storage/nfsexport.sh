#!/bin/bash

for i in drivers infrastructure lixeiras manager marketing owner profiles public security devel homes; do echo -e "/srv/asf/samba/$i  \t\t192.168.1.0/24(rw,no_root_squash,no_subtree_check)" >> /etc/exports; done
