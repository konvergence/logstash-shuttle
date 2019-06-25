FROM logstash:5.6.16

MAINTAINER Slaheddinne Ahmed, slaheddinne.ahmed@kshuttle.io

# Image Label
LABEL maintainer="kshuttle.io" \
      description="logstash for shuttle logs" \
      release="5.6.16"

RUN apt-get update \
    && apt-get install -y gettext-base \
  && echo "### get last GeoLite2-City database" \
    && curl -s -L https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz -o /tmp/GeoLite2-City.tar.gz \
    && tar -zxvf /tmp/GeoLite2-City.tar.gz  -C /tmp \
    && cd  /tmp/GeoLite2-City_* \
    && mkdir /config-dir/ \
    && mv GeoLite2-City.mmdb /config-dir/ \
  && echo "#### clean " \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*




COPY /assets/conf/ /config-dir/
COPY README.md    /config-dir/




# metadata

ENV STACK_CLIENT=mystack \
    EL_HOST=es \
    EL_PORT=9200 \
    EL_INDEX=staging_prod \
    EL_USER=logstash \
    EL_PASSWORD=logstash \
    EL_SSL=true \
    EL_SSL_VERIF_CERT=false\
    LOG_VERSION=v03 \
    LOG_BASE_DIR=/data/shuttle/home/logs \
    AUDIT_FILES=audit/ShuttleAudit.csv \
    USERS_FILES=users/users \
    OUTPUT_ONLY=false \
    SINCE_DB= \
    LOGSTASH_OPTIONS=
            
WORKDIR /config-dir
#VOLUME [ "/config-dir" ]
COPY /bin/entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["--help"]

