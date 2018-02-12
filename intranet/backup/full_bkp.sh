#!/bin/bash
    
data=`date +%Y-%m-%d`
rdir='/srv/asf/backups'

asf='/var/www/asf.com/public_html'
logs='/var/log/apache2'
express='/srv/www/express'

xfsdump -l 0 -L backup - $asf | gzip | ssh -p 52030 root@storage dd of=$rdir/asf/asf-$data.0.dump.gz
xfsdump -l 0 -L backup - $logs | gzip | ssh -p 52030 root@storage dd of=$rdir/logs/logs-$data.0.dump.gz
xfsdump -l 0 -L backup - $express | gzip | ssh -p 52030 root@storage dd of=$rdir/express/express-$data.0.dump.gz

