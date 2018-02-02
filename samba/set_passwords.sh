#!/bin/bash

list="$(samba-tool user list | egrep -v 'Administrator|Guest|krbtgt')"

for user in $list
    do
        samba-tool user setpassword $user --newpassword=123Mudar --must-change-at-next-login
done
