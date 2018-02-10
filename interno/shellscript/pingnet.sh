#!/bin/bash

# This script use ICMP protocol for communicate in all nodes of the net
# work, use only C class networks, not use subnets, this is a simple ex
# ample for use the conditional structures (if, else) and an a (for) lo
# op in Shell Script lessons. 

# Este script usa o protocolo ICMP para se comunicar com todos os nodes
# da rede, use somente redes de classe C, não use subredes, isto é um s
# imples exemplo de utilizacão pa ra a estrutura condicional (if, else)
# e um loop (for) em aulas de Shell Script.

clear

SPAWN='/tmp/NET'
echo -e "\nInput the network: Ex.: 192.168.1.0/24"
read ADDR

> $SPAWN
echo $ADDR > $SPAWN

NET=`awk -F. '{print $3}' $SPAWN`
ROUT=`ip r | grep $( cat $SPAWN) | cut -d' ' -f1`

if [ "$ROUT" == '' ]
    then
        echo -e "\nThis node not have a route to $ADDR\n"
	exit
    else
	echo -e "\nList of active hosts for ICMP:"
        for IP in `seq 1 254`
	    do
	        ping -c 1 192.168.$NET.$IP | grep 'ttl=64' | cut -d' ' -f4 | sed -e s'|.$||'
	done
fi
