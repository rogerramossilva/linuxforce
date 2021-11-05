#!/bin/bash

# Array com grupos de sistema
all_groups=('infrastructure' 'security' 'public' 'manager' 'marketing' 'owner' 'devel')

for group in ${all_groups[@]}
    do
	samba-tool group add $group
        case $group in
	    infrastructure)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group elliot.alderson
                samba-tool group addmembers $group lloyd.chung
	    ;;
            security)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group elliot.alderson
                samba-tool group addmembers $group lloyd.chung
            ;;
	    devel)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group elliot.alderson
                samba-tool group addmembers $group lloyd.chung
                samba-tool group addmembers $group webmaster
            ;;
            public)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group elliot.alderson
                samba-tool group addmembers $group lloyd.chung
                samba-tool group addmembers $group angela.moss
                samba-tool group addmembers $group ollie.parker
            ;;
            manager)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group angela.moss
                samba-tool group addmembers $group ollie.parker
	    ;;
            marketing)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
                samba-tool group addmembers $group angela.moss
                samba-tool group addmembers $group ollie.parker
	    ;;
            owner)
                samba-tool group addmembers $group analista
                samba-tool group addmembers $group gideon.goddard
	    ;;
    esac
done
