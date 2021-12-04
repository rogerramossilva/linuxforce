#!/bin/bash

# Rede interna
GTW=192.168.1.1
INT=192.168.1.10
DTC=192.168.1.20
STG=192.168.1.30
CLI=192.168.1.100
LAN=192.168.1.0/24

# Link Dedicado (FAKE INTERNET)
FWL1=200.50.100.10
FWL2=200.50.100.20
FWL3=200.50.100.30
EXT=200.50.100.100
LNK=200.50.100.0/24

# Internet
DIP=10.0.2.15
WAN=10.0.2.0/24

# VPN
CVP=10.0.0.100
SVP=10.0.0.200
VPN=10.0.0.0/24

# Habilita o passagem de pacotes
echo 1 > /proc/sys/net/ipv4/ip_forward

# Politicas padroes do firewall
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Limpa todas chains
iptables -t nat -F
iptables -t filter -F

# Limpa a chain drop-it, se ela existir
if [ -n "`iptables -L | grep drop-it`" ]
    then
        iptables -F drop-it
fi

# Limpa a chain syn-flood, se ela existir
if [ -n "`iptables -L | grep syn-flood`" ]
    then
        iptables -F syn-flood
fi

# Limpa a chain ndrop-it, se ela existir
if [ -n "`iptables -L | grep ndrop-it`" ]
    then
        iptables -F ndrop-it
fi

# Limpa as chains de usuarios
iptables -X

# Zera os contadores do iptables
iptables -Z

# Cria DROP chain
iptables -N drop-it
#iptables -A drop-it -j LOG --log-level info
iptables -A drop-it -j REJECT

# Cria a SYN-FLOOD chain
iptables -N syn-flood

# Habilita a protecao syn-flood
iptables -A syn-flood -p tcp --syn -m limit --limit 1/s -j RETURN

# Habilita a proteção contra PORT SCANNERS
iptables -A syn-flood -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN

# Habilita a proteção contra o ping da morte
iptables -A syn-flood -p icmp --icmp-type echo-request -m limit --limit 1/s -j RETURN
iptables -A syn-flood -j DROP

# Cria NDROP chain
iptables -N ndrop-it

#iptables -A ndrop-it -j LOG --log-level info
iptables -A ndrop-it -j REJECT

#####################
### INPUT SESSION ###
#####################

# 0 - Aceita somente pacotes de redes validas
iptables -A INPUT -i enp0s3 -s 192.168.0.0/16 -j drop-it
iptables -A INPUT -i enp0s3 -s 172.16.0.0/12 -j drop-it
iptables -A INPUT -i enp0s3 -s 10.0.0.0/8 -j drop-it

# 1 - Habilita o loopback
iptables -A INPUT -i lo -j ACCEPT

# 2 - Permite o retorno de conexoes estabelecidas e relacionadas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3 - Habilita a entrada do ICMP
iptables -A INPUT -p icmp --icmp-type echo-request -i enp0s8 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -i enp0s9 -j ACCEPT

# 4 - Habilita o SSH do node Cliente Interno e Externo
#iptables -A INPUT -p tcp -i enp0s8 -s $CLI -d $GTW --dport 52001 -j ACCEPT

# 5 - Habilita o INPUT do NTP para clientes Internos e Externo
#iptables -A INPUT -p udp -i enp0s8 -s $LAN -d $GTW --dport 123 -j ACCEPT
#iptables -A INPUT -p udp -i enp0s9 -s $EXT -d $FWL1 --dport 123 -j ACCEPT

# 6 - Habilita o INPUT vindo de DNSs para o gateway
#iptables -A INPUT -i enp0s3 -d $DIP -p udp --sport 53 -j ACCEPT

# 7 - Habilita o INPUT para o proxy. OBS: Desabilitar FORWARD para 80 e 443
#iptables -A INPUT -p tcp -i enp0s8 -s $LAN -d $GTW --dport 3128 -j ACCEPT

# 8 - Habilita o INPUT para VPN vindo do cliente Externo
#iptables -A INPUT -p udp -i enp0s9 -s $EXT -d $FWL1 --dport 1194 -j ACCEPT

# 9 - Permite acesso a aplicacao interna via VPN
#iptables -A INPUT -p tcp -i tun0 -s $CVP -d $SVP -m multiport --dports 80,443 -j ACCEPT 

# 10 - Descomentar para permitir log de descarte
#iptables -A INPUT -j drop-it

######################
### OUTPUT SESSION ###
######################

# 0 - Envia pacotes somente a redes validas
iptables -A OUTPUT -o enp0s3 -d 192.168.0.0/16 -j drop-it
iptables -A OUTPUT -o enp0s3 -d 172.16.0.0/12 -j drop-it
iptables -A OUTPUT -o enp0s3 -d 10.0.0.0/8 -j drop-it

# 1 - Habilita o loopback
iptables -A OUTPUT -o lo -j ACCEPT

# 2 - Permite o retorno de conexoes estabelecidas e relacionadas
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3 - Habilita o OUTPUT do ICMP
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

# 4 - Habilita o OUTPUT do NTP
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

# 5 - Habilita a resolucao de nomes 
iptables -A OUTPUT -o enp0s3 -p udp -d 8.8.8.8 --dport 53 -j ACCEPT
#iptables -A OUTPUT -p udp -d $INT --dport 53 -j ACCEPT
#iptables -A OUTPUT -p udp -d $INT --dport 53 -j ACCEPT

# 6 - Habilita o OUTPUT para HTTP e HTTPS
iptables -A OUTPUT -p tcp -o enp0s3 -s $DIP -m multiport --dports 80,443 -j ACCEPT

# 7 - Habilita o OUTPUT para autenticar no OpenLDAP
#iptables -A OUTPUT -p tcp -o enp0s8 -s $GTW -d $DTC --dport 389 -j ACCEPT

# 8 - Habilita o envio de logs para o node Storage
#iptables -A OUTPUT -p udp -o enp0s8 -s $GTW -d $STG --dport 514 -j ACCEPT

# 9 - Descomentar para permitir log de descarte
#iptables -A OUTPUT -j drop-it

###############
### FORWARD ###
###############

# 1 - Permite o FORWARD do ICMP
iptables -A FORWARD -p icmp -s $LAN --icmp-type echo-request -o enp0s3 -j ACCEPT
iptables -A FORWARD -p icmp -s $LAN --icmp-type echo-request -o enp0s9 -j ACCEPT

# 2 - Permite o retorno de conexoes estabelecidas
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# 3 - Habilita o FORWARD da LAN para HTTP e HTTPS
iptables -A FORWARD -p tcp -s $LAN -o enp0s3 -m multiport --dports 80,443 -j ACCEPT
iptables -A FORWARD -p tcp -s $LAN -o enp0s9 -m multiport --dports 80,443 -j ACCEPT

# 4 - Habilita o FORWARD para DNSs
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -j ACCEPT

# 5 - Habilita o FORWARD da LAN para MTAs
iptables -A FORWARD -p tcp -s $LAN -m multiport --dports 25,110,143,587,993,995 -j ACCEPT

# 6 - Habilita o FORWARD da LAN para FTPs
iptables -A FORWARD -p tcp -s $LAN -o enp0s3 -m multiport --dports 20,21 -j ACCEPT 

# 7 - Habilita a passagem do SSH entre cliente Externo e Interno
#iptables -A FORWARD -p tcp -i enp0s9 -s $EXT -d $CLI --dport 52100 -j ACCEPT

# 8 - Habilita o FORWARD para acesso ao MTA
#iptables -A FORWARD -p tcp -i enp0s9 -s $LNK -d $DTC -m multiport --dports 25,110,143,587,993,995 -j ACCEPT

# 9 - Habilita o FORWARD para acesso ao WWW
#iptables -A FORWARD -p tcp -i enp0s9 -s $LNK -d $INT -m multiport --dports 80,443 -j ACCEPT

# 10 - Habilita o FORWARD para autenticacao externa no LDAP
#iptables -A FORWARD -p tcp -i enp0s9 -s $LNK -d $DTC --dport 389 -j ACCEPT

# 11 - Descomentar para permitir log de descarte
#iptables -A FORWARD -j drop-it

###################
### NAT SESSION ###
###################

# 1 - Habilita o acesso a internet para LAN
iptables -t nat -A POSTROUTING -s $LAN -o enp0s3 -j MASQUERADE

# 2 - Habilita a resolucao de nomes do cliente Externo
#iptables -t nat -A PREROUTING -p udp -i enp0s9 -s $LNK -d $FWL1 --dport 53 -j DNAT --to-destination $INT:53
#iptables -t nat -A PREROUTING -p udp -i enp0s9 -s $LNK -d $FWL2 --dport 53 -j DNAT --to-destination $DTC:53

# 3 - Habilita o acesso SSH do cliente externo para o node Interno
#iptables -t nat -A PREROUTING -p tcp -i enp0s9 -s $EXT -d $FWL1 --dport 52100 -j DNAT --to-destination $CLI:52100

# 4 - Habilita acesso do cliente Externo a aplicacao
#for WEB in 80 443
#    do
#        iptables -t nat -A PREROUTING -p tcp -i enp0s9 -s $LNK -d $FWL1 --dport $WEB -j DNAT --to-destination $INT:$WEB
#done 

# 5 - Habilita acesso do clente Externo ao MTA
#for MAIL in 25 110 143 587 993 995
#    do
#        iptables -t nat -A PREROUTING -p tcp -d $FWL2 --dport $MAIL -j DNAT --to-destination $DTC:$MAIL
#done

# 6 - Habilita autenticacao LDAP para cliente Externo
#iptables -t nat -A PREROUTING -p tcp -i enp0s9 -s $LNK -d $FWL2 --dport 389 -j DNAT --to-destination $DTC:389

#Personal Firewall
iptables -A INPUT -p tcp --dport 22001 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

if [ $? == 0 ] ; then 
  service iptables save
  mkdir -p /etc/firewall
  iptables-save > /etc/firewall/firewall.sh
fi
