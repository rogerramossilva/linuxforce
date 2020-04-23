#/bin/bash

mkdir -p /var/bind9/chroot/{etc,dev,var/cache/bind,var/run/named}
mv /etc/bind /var/bind9/chroot/etc
mknod /var/bind9/chroot/dev/null c 1 3
mknod /var/bind9/chroot/dev/random c 1 8
chmod 660 /var/bind9/chroot/dev/{null,random}
ln -s /var/bind9/chroot/etc/bind /etc/bind
cp /etc/localtime /var/bind9/chroot/etc/
chown bind:bind /var/bind9/chroot/etc/bind/rndc.key
chmod 775 /var/bind9/chroot/var/{cache/bind,run/named}
chgrp bind /var/bind9/chroot/var/{cache/bind,run/named}
echo "\$AddUnixListenSocket /var/bind9/chroot/dev/log" > /etc/rsyslog.d/bind-chroot.conf
