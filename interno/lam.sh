#!/bin/bash

apt install apt install ldap-account-manager apache2 -y

apt -y install apache2 php php-cgi libapache2-mod-php php-mbstring php-common php-pear

apt install php7.4-fpm php7.4-imap php7.4-mbstring php7.4-mysql php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-bz2 php7.4-intl php7.4-gmp php7.4-redis -y

cd /etc/apache2/sites-available/

wget https://github.com/rogerramossilva/linuxforce/raw/master/interno/lam.conf

a2ensite lam
a2enconf php*-cgi

systemctl restart apache2
