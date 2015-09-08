#!/usr/bin/env bash
set -e
# Configure SPM 
if [ -n "$SPM_CFG" ]; then
	for cfg in "$(echo $SPM_CFG | tr ";" "\n")"
	do
	  echo "$cfg"
	  bash /opt/spm/bin/spm-client-setup-conf.sh ${cfg}
	  # Check for standalone monitors
	  case "$cfg" in
	    *standalone* ) export SPM_STANDALONE="enabled"; echo "Standalone Monitor enabled for: $cfg";;
	  esac
	done
fi

/etc/init.d/collectd start
/etc/init.d/spm-sender start
if [  "$SPM_STANDALONE_MONITOR" == "disabled" ]; then
	echo "Standalone monitor is disabled"
else
	/etc/init.d/spm-monitor start
	tail -f /opt/spm/spm-monitor/logs/spm-monitor.log &
fi
tail -f /opt/spm/spm-sender/logs/spm-sender.log

