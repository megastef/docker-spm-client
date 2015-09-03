#!/bin/bash
set -e
/bin/bash /opt/spm/bin/spm-client-setup-conf.sh $SPM_TOKEN es javaagent
# /bin/bash /opt/spm/bin/spm-client-setup-conf.sh $SPM_TOKEN network standalone network
# sed -i s/eth0/docker0/g /opt/spm/spm-monitor/conf/spm-monitor-network-config-${SPM_TOKEN}-default.properties
/etc/init.d/collectd start
/etc/init.d/spm-sender start
# /etc/init.d/spm-monitor start
exec "$@"
tail -f /opt/spm/spm-sender/logs/spm-sender.log
 
