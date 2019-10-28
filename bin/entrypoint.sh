#!/bin/sh


if [ "$1" = "--run" ]; then
    envsubst < /config-dir/shuttle-"$LOG_VERSION".conf.dist > /config-dir/logstash.conf

    if [ "${OUTPUT_MODE}" = "elasticsearch" ]; then
          envsubst < /config-dir/output-es-"$LOG_VERSION".conf.dist >> /config-dir/logstash.conf
    else
          envsubst < /config-dir/output-kafka-"$LOG_VERSION".conf.dist >> /config-dir/logstash.conf
    fi

    logstash $LOGSTASH_OPTIONS -f /config-dir/logstash.conf
else
    cat  README.md
fi
