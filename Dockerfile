FROM logstash:5.6.16

# Image Label
LABEL maintainer="kshuttle.io" \
      description="logstash for shuttle logs" \
      release="5.6.16"

RUN apt-get update \
    && apt-get install -y gettext-base \
  && echo "#### clean " \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*




# put GeoLite2 database
COPY /GeoLite2/ /GeoLite2/
RUN echo "### get last GeoLite2-City database" \
      && tar -zxvf /GeoLite2/GeoLite2-City_20201027.tar.gz  -C /tmp \
      && cd  /tmp/GeoLite2-City_* \
      && mkdir /config-dir/ \
      && mv GeoLite2-City.mmdb /config-dir/ \
      && rm -rf /tmp/*

COPY /assets/conf/ /config-dir/
COPY README.md    /config-dir/




# metadata

ENV STACK_CLIENT=mystack \
    EL_HOST=es \
    EL_PORT=9200 \
    EL_INDEX=shuttle- \
    EL_INDEX_SUFFIX=-%{+YYYY.MM.dd} \
    EL_USER=logstash \
    EL_PASSWORD=logstash \
    EL_SSL=true \
    EL_SSL_VERIF_CERT=false\
    LOG_VERSION=v04 \
    LOG_BASE_DIR=/data/shuttle/home/logs \
    AUDIT_FILES=audit/ShuttleAudit.csv \
    USERS_FILES=users/users \
    OUTPUT_ONLY=false \
    OUTPUT_MODE=elasticsearch \
    SINCE_DB= \
    SHUTTLE_FILES=Shuttle.log \
    LOGSTASH_OPTIONS= \
    KAFKA_SERVER=kafka:9092





WORKDIR /config-dir
#VOLUME [ "/config-dir" ]
COPY /bin/entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["--help"]
