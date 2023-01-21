for i in devel drivers infrastructure lixeiras manager marketing owner profiles public security; do lvcreate -L 2G -n $i storage; done
lvcreate -L 25G -n homes storage
