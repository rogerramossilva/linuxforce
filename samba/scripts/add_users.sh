#!/bin/bash

list="$(getent passwd | awk -F: '$3 >= 1000 {print $1}' | grep -v nobody)"

for user in $list
    do
        samba-tool user add $user 123Mudar --home-drive=H: --script-path=logon.vbs --home-directory=\\\\asf\\$user --profile-path=\\\\asf\\profiles\\$user
done
