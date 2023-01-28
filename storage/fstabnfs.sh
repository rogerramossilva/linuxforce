#!/bin/bash

for i in $(showmount -e 192.168.1.30 |egrep samba |awk -F " " '{ print $1 }'); do echo "192.168.1.30:$i $i nfs defaults 0 0 " >> /etc/fstab ; done
