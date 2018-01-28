#!/bin/bash
        
# This script is an example of using the 'case' structure for shell script lessons, 
# must used for internal nodes, not must using for gateway node because this ACCEPT
# policies aren't secure for nodes exposed at internet.

# Este script é um exemplo de uso para a estrutura 'case' em aulas de Shell Script,
# deve ser usado somente em nodes internos e não deve ser usado em um node gateway
# devido as politicas ACCEPT não serem seguras para nodes expostos a internet.

# LAN
GTW=192.168.1.1
DTC=192.168.1.20
STG=192.168.1.30
CLI=192.168.1.100
INT=192.168.1.10
LAN=192.168.1.0/24

# LINK
FWL1=200.50.100.10
FWL2=200.50.100.20
FWL3=200.50.100.30
EXT=200.50.100.100
LNK=200.50.100.0/24

# Internet
DIP=10.0.2.15
WAN=10.0.2.0/24

case $1 in
    stop)
    
	# Disable packet forwarding
	echo 0 > /proc/sys/net/ipv4/ip_forward

	# Setting ACCEPT policies for filter chains
	iptables -P INPUT ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -P FORWARD ACCEPT
	# Flush all chains 
	iptables -t nat -F
	iptables -t filter -F

	# Firewall briefing status
        echo 'firewall.sh stop...  [ OK ]'
    
    ;;

    start)

	# Enable packet forwarding
	echo 1 > /proc/sys/net/ipv4/ip_forward

	# Setting default DROP policies..."
	iptables -P INPUT DROP
	iptables -P OUTPUT DROP
	iptables -P FORWARD DROP
	# Flush all chains 
	iptables -t nat -F
	iptables -t filter -F

        # Clean drop-it chain, if exists
        if [ -n "`iptables -L | grep drop-it`" ]
	    then
	        iptables -F drop-it
        fi
        # Clean syn-flood chain, if exists
        if [ -n "`iptables -L | grep syn-flood`" ]
	    then
	        iptables -F syn-flood
        fi
        # Clean  ndrop-it chain, if exists
        if [ -n "`iptables -L | grep ndrop-it`" ]
	    then
	         iptables -F ndrop-it
	fi

	# Clean users chains
	iptables -X
	# Clean all iptables counters
	iptables -Z
	# Make a DROP chain
	iptables -N drop-it
	#iptables -A drop-it -j LOG --log-level info 
	iptables -A drop-it -j REJECT
	# Make a SYN-FLOOD chain
	iptables -N syn-flood
	# Enable Syn-floods protection
	iptables -A syn-flood -p tcp --syn -m limit --limit 1/s -j RETURN
	# Enable Port scanners protection
	iptables -A syn-flood -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN
	# Enable Ping of Dead protection
	iptables -A syn-flood -p icmp --icmp-type echo-request -m limit --limit 1/s -j RETURN
	iptables -A syn-flood -j DROP
	# Make a new DROP chain                                                             
	iptables -N ndrop-it
	#iptables -A ndrop-it -j LOG --log-level info
	iptables -A ndrop-it -j REJECT
	
	#####################
        ### INPUT SESSION ###
        #####################
	
	# Accept packets only valid networks for external interface
	iptables -A INPUT -i enp0s3 -s 192.168.0.0/16 -j drop-it
	iptables -A INPUT -i enp0s3 -s 172.16.0.0/12 -j drop-it
	iptables -A INPUT -i enp0s3 -s 10.0.0.0/8 -j drop-it
	# Enable loopback
	iptables -A INPUT -i lo -j ACCEPT
	# Enable ICMP for local network interfaces
	iptables -A INPUT -p icmp --icmp-type echo-request -i enp0s8 -j ACCEPT
	iptables -A INPUT -p icmp --icmp-type echo-request -i enp0s9 -j ACCEPT
	# Enable connections are state established and related
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	# Uncomment for enable log
	#iptables -A INPUT -j drop-it

	######################
	### OUTPUT SESSION ###
	######################

	# Send packets only valid networks
	iptables -A OUTPUT -o enp0s3 -d 192.168.0.0/16 -j drop-it
	iptables -A OUTPUT -o enp0s3 -d 172.16.0.0/12 -j drop-it
	iptables -A OUTPUT -o enp0s3 -d 10.0.0.0/8 -j drop-it
	# Enable Loopback
	iptables -A OUTPUT -o lo -j ACCEPT
	# Enable connections are state established and related
	iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	# Enable ICMP OUTPUT
	iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
	# Enable OUTPUT for Google DNS
	iptables -A OUTPUT -o enp0s3 -p udp -d 8.8.8.8 --dport 53 -j ACCEPT
	# Enable OUTPUT for HTTP e HTTPS
	iptables -A OUTPUT -p tcp -o enp0s3 -s $DIP -m multiport --dports 80,443 -j ACCEPT
	# Uncomment for enable log
	#iptables -A OUTPUT -j drop-it

	###############
	### FORWARD ###
	###############

	# Enable ICMP FORWARD
	iptables -A FORWARD -p icmp -s $LAN --icmp-type echo-request -o enp0s3 -j ACCEPT
	iptables -A FORWARD -p icmp -s $LAN --icmp-type echo-request -o enp0s9 -j ACCEPT
	# Enable connections are state established and related
	iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
	# Enable FORWARD for HTTP e HTTPS
	for REP in $INT $DTC $STG $CLI ; do 
	iptables -A FORWARD -p tcp -s $REP -o enp0s3 -m multiport --dports 80,443 -j ACCEPT
	iptables -A FORWARD -p tcp -s $REP -o enp0s9 -m multiport --dports 80,443 -j ACCEPT
	done
	# Enable FORWARD for DNS
	iptables -A FORWARD -p udp --dport 53 -j ACCEPT
	# Enable LAN FORWARD for MTAs
	iptables -A FORWARD -p tcp -s $LAN -m multiport --dports 25,110,143,587,993,995 -j ACCEPT
	# Enable LAN FORWARD for FTPs
	iptables -A FORWARD -p tcp -s $LAN -o enp0s3 -m multiport --dports 20,21 -j ACCEPT 
	# Uncomment for enable log
	#iptables -A FORWARD -j drop-it

	###################
	### NAT SESSION ###
	###################

	# Enable internet access for LAN
	iptables -t nat -A POSTROUTING -s $LAN -o enp0s3 -j MASQUERADE
	# Firewall briefing status
	echo 'firewall.sh start... [ OK ]'
	service iptables save
    
    ;;
    
    restart)    
        $0 stop
	sleep 0.5
	$0 start
    ;;

    *)
        echo 'USE: iptables.sh start|stop|restart'
    ;;
esac
