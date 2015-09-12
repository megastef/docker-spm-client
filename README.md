# SPM Client 

This image contains [SPM](https://www.sematext.com/spm) Client in a Docker Container. 

SPM Client is an application monitoring agent for the following Applications: 
- [Solr & SolrCloud](http://sematext.com/spm/integrations/solr-monitoring.html), 
- [Elasticsearch](http://sematext.com/spm/integrations/elasticsearch-monitoring.html)
- [Apache Spark](http://sematext.com/spm/integrations/spark-monitoring.html), Storm, Kafka
- [Apache Cassandra](http://sematext.com/spm/integrations/cassandra-monitoring.html), 
- [HBase](http://sematext.com/spm/integrations/hbase-monitoring.html)
- [Hadoop](http://sematext.com/spm/integrations/hadoop-monitoring.html) MapReduce, HDFS, YARN
- Apache2 and Apache Tomacat Webservers 
- Nginx, Nginx Plus, 
- HAProxy
- Redis, Memcached
- MySQL & MariaDB
- AWS EC2, ELB, EBS, RDS
- Java/Scala Applicatiosn (JVM)

Please note there are separate monitoring agents available for other technologies not covered by SPM Client: 
- [Docker](http://sematext.com/spm/integrations/docker-monitoring.html) 
- [CoreOS and DEIS PaaS](http://sematext.com/spm/integrations/coreos-monitoring.html) 
- [Node.js](http://sematext.com/spm/integrations/nodejs-monitoring.html), Express, Hapi.js, Koa Apps ...


# Installation 

```
# multiple Apps can be configured using ";" as separator
# SPM_CFG="YOUR_SPM_CONFIG_STRINGS"
# Elasticsearch Example
export SPM_CFG="YOUR_SPM_TOKEN es javagent jvmname:ES1"
docker run --name spm-client --restart=always -e SPM_CFG sematext/spm-client
```

Run your application:

In the following example we see options, for the SPM In-Process monitor to inject a .jar file from SPM Client Volume.
The ES_JAVA_OPTS string is taken from SPM install instructions - using the SPM Token and naming the JVM (in case you like to run N instances on the same host). 

```
docker run -d --name “ES1” -d --volumes-from spm-client -e ES_JAVA_OPTS="-Dcom.sun.management.jmxremote -javaagent:/opt/spm/spm-monitor/lib/spm-monitor-es.jar=YOUR_SPM_TOKEN::ES1 -es.node.name=ES1" -p9200:9200 elasticsearch 
```

Parameters:
- SPM_CFG - Multiple App configurations for spm-client-setup-conf.sh separated by ";". 

An alternative way to configure SPM Client, applicable for scenarios not coverd in the simplified SPM_CFG variable: 
Configure SPM Client as described in Sematext documentation using the setup scripts, called via "docker exec -it spm-client your_linux_command":
```
# configure Elasticsearch give jvmname 'ES1'
docker exec -it spm-client /bin/bash /opt/bin/spm-setup-conf.sh YOUR_SPM_TOKEN es javagent jvmname:ES1
# persist config changes
docker commit spm-client
```

# Support
- Follow us on Twitter [@sematext](http://twitter.com/sematext)
- E-Mail support: support@sematext.com
- Support [Chat](https://apps.sematext.com/users-web/login.do) 


# Building the image

```
export IMAGE_NAME=megastef/spm-client
docker rmi $IMAGE_NAME
docker build -t $IMAGE_NAME .
```
