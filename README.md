

# Logstash-shuttle

**Logstash-shuttle** is a docker image based on [logstash]([https://hub.docker.com/r/library/logstash/tags/](https://hub.docker.com/r/library/logstash/tags/)) official image and customized to parse and treat **Shuttle** logs as event streams for later analysis .

For further reading please refer to [https://12factor.net/logs](https://12factor.net/logs).

The image is aimed to be used along side a Shuttle server and shares it's log directory , but in order to produce an [ephemeral]([https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#containers-should-be-ephemeral](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#containers-should-be-ephemeral)) container you can use it with only a named volume.

```yaml

konvergence/logstash-shuttle

```

## Usage

#### Available commands :

`-- run` runs the image

`-- help` shows avaible commands and environement variables.

#### Environement variables

|Variable |Description |Default value |
|--|--|--|
| `STACK_CLIENT`| Identifies a client logs. |`mystack` |
| `SINCE_DB`| Set it to `sincedb_path => "/dev/null"` to force logstash-shuttle to read files from the begining even if they have been seen already.|
| `LOG_VERSION`| Specifies logs version. |`v04`|
| `LOG_BASE_DIR`| Specifies the directory where logs are located in shuttle volume .|`/data/shuttle/home/logs`.|
| `AUDIT_FILES`| Specifies the audit file(s) to be parsed/treated. you can use regex . LOG_BASE_DIR/AUDIT_FILES|`audit/ShuttleAudit.csv`|
| `USERS_FILES`|Specifies users declared file(s) to be parsed/treated. you can use regex. LOG_BASE_DIR/USERS_FILES|`users/users`|
| `SHUTTLE_FILES`| Shuttle.log pattern LOG_BASE_DIR/SHUTTLE_FILES|`Shuttle.log`|
| `OUTPUT_ONLY`| If set to true you will get the logs in the standard output else to elasticsearch. |`false`|
| `OUTPUT_MODE`| elasticsearch, kafka, stdout | `elasticsearch` |
| `EL_HOST`| Elasticsearch host. |`es`|
| `EL_PORT`| Elasticsearch port. |`9200`|
| `EL_INDEX`|elasticsearch index prefix.|`shuttle-`|
| `EL_INDEX_SUFFIX`|elasticsearch index suffix.|`-%{+YYYY.MM.dd}`|
| `EL_USER`|elasticsearch index where logs will be stored.|`logstash`|
| `EL_PASSWORD`|elasticsearch index where logs will be stored.|`logstash`|
| `EL_SSL`|enable ssl communication with eslasticsearch.  |`true` |
| `EL_SSL_VERIF_CERT`|enable ssl certificate verification.|`false`|
| `KAFKA_SERVER`| kafaka bootstrap server | `kafka:9092` |



## Getting Started
These instructions will get you a copy of the project on your local machine for development and testing purposes.


#### changelogs
2.7 : use logstash:5.6.16  and give v04 config
2.8 : use logstash:5.6.16  update give v04 config with TZ (issue with logstash:7.13.1 )


#### Logs versions & shuttle compatibility

|Logs version| shuttle vesions |
|--|--|
| v01|  shuttle 4.5+ audit logs|
| v02|  shuttle 4.10+ audit logs|
| v03|  shuttle 4.10+ audit logs with geoip infos|
| v04|  shuttle 4.10+ audit logs with geoip infos and shuttle logs, allow output to kafka or elasticsearch|

## Getting Started

These instructions will get you a copy of the project on your local machine for development and testing purposes.

### Prerequisites

--Docker installed on your local machine.

--Grafana running server for data viz.

### warning about geoip
before send any data, you must define mapping type of geoip into the index

                    "geoip": {
                        "dynamic": true,
                        "properties": {
                            "ip": {
                                "type": "ip"
                            },
                            "latitude": {
                                "type": "half_float"
                            },
                            "location": {
                                "type": "geo_point"
                            },
                            "longitude": {
                                "type": "half_float"
                            }
                        }
                    }

### Installing

A step by step series of examples that tell you have to get a development env running

1. Download or clone the repository.

2. Run elasticsearch first

```

cd test-example/elasticsearch

docker-compose up -d

```

3. Then run shuttle stack

```

cd test-example/shuttle

docker-compose up -d

```

## Running the tests

This section aims to describe how to check if everything works as expected.

1 - Run `docker ps `, you should be able to see 4 running containers (Shuttle server, Postgres , Logstash-shuttle and Elasticsearch).

2 - Check **logstash-shuttle** logs with `docker logs shuttle_logstash_1` , to see if elasticsearch and logstash-shuttle are linked.

> INFO logstash.outputs.elasticsearch - New Elasticsearch output {:class=>"LogStash::Outputs::ElasticSearch", :hosts=>["//es:9200"]}

> INFO logstash.agent - Successfully started Logstash API endpoint {:port=>9600}

## Versioning

I use [Github]([https://github.com/](https://github.com/)) for versioning. For the versions available, see the [releases on this repository]([https://github.com/slassh/logstash-shuttle/releases](https://github.com/slassh/logstash-shuttle/releases)).

## Authors

* **kShuttle infra team**
