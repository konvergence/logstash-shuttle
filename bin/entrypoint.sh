#!/bin/sh

if [ "$1" = "--help" ]
then
	cat  README.md
else
	if [ $1 = "--run" ] && [ $OUTPUT_ONLY = "true" ] #debug mode
	then
		envsubst < /config-dir/debug_shuttle-"$LOG_VERSION".conf.dist > /config-dir/logstash.conf 
	elif [ $1 = "--run" ] && [ $OUTPUT_ONLY = "false" ] #elasticsearch mode
	then
		envsubst < /config-dir/shuttle-"$LOG_VERSION".conf.dist > /config-dir/logstash.conf
	fi

#cat /config-dir/$LOGSTASH_CONF
	logstash $LOGSTASH_OPTIONS -f /config-dir/logstash.conf

fi
