#!/bin/bash

LISTA="$(samba-tool user list | egrep -v 'Administrator|Guest|krbtgt|dns-fileserver')"

for user in $LISTA
    do
        samba-tool user setpassword $user --newpassword=123Mudar --must-change-at-next-login
done
