#!/bin/sh


if [ "$1" = "--help" ]
then
	echo "hello  this is help me file \n please refer to the image maintainer (slaheddinne)  "
else
	apt-get update
	apt-get install -y gettext-base
	if [ $1 = "--run" ] && [ $OUTPUT_ONLY = "true" ] #debug mode
	then
		envsubst < /config-dir/debug_shuttle-"$SHUTTLE_VERSION".conf.dist > /config-dir/logstash.conf 
	elif [ $1 = "--run" ] && [ $OUTPUT_ONLY = "false" ] #elasticsearch mode
	then
		envsubst < /config-dir/shuttle-"$SHUTTLE_VERSION".conf.dist > /config-dir/logstash.conf
	fi

#cat /config-dir/$LOGSTASH_CONF
	logstash $LOGSTASH_OPTIONS -f /config-dir/logstash.conf

fi	