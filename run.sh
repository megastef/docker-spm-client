#!/bin/bash
set -e
/etc/init.d/collectd start
/etc/init.d/spm-sender start
if [  "$SPM_STANDALONE_MONITOR" == "disabled" ]; then
	echo "Standalone monitoring is disabled"
else
	/etc/init.d/spm-monitor start
	tail -f /opt/spm/spm-monitor/logs/spm-monitor.log &
fi
tail -f /opt/spm/spm-sender/logs/spm-sender.log

 
