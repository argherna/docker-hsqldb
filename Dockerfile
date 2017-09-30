FROM openjdk:8-jre

MAINTAINER Andy Gherna

ENV MVN_CENTRAL_URL http://central.maven.org/maven2
ENV HSQLDB_MVN_GRP org/hsqldb
ENV HSQLDB_VERSION 2.4.0
ENV LOG4J_VERSION 1.2.17

RUN mkdir -p /opt/hsqldb/lib \
    && wget -O /opt/hsqldb/lib/hsqldb.jar \
       "${MVN_CENTRAL_URL}/${HSQLDB_MVN_GRP}/hsqldb/${HSQLDB_VERSION}/hsqldb-${HSQLDB_VERSION}.jar" \
    && wget -O /opt/hsqldb/lib/sqltool.jar \
       "${MVN_CENTRAL_URL}/${HSQLDB_MVN_GRP}/sqltool/${HSQLDB_VERSION}/sqltool-${HSQLDB_VERSION}.jar" \
    && wget -O /opt/hsqldb/lib/log4j.jar \
       "${MVN_CENTRAL_URL}/log4j/log4j/${LOG4J_VERSION}/log4j-${LOG4J_VERSION}.jar" \
    && mkdir -p /etc/opt/hsqldb/conf \
    && mkdir -p /var/opt/hsqldb/sql \
    && mkdir -p /var/opt/hsqldb/data \
    && mkdir -p /var/opt/hsqldb/run \
    && groupadd -r hsqldb \
    && useradd -l -r -g hsqldb hsqldb 

COPY docker-entrypoint.sh /usr/local/bin/
COPY conf/ /etc/opt/hsqldb/conf/
COPY sql/ /var/opt/hsqldb/sql/

RUN chown hsqldb:hsqldb -R /opt/hsqldb \
    && chown hsqldb:hsqldb -R /var/opt/hsqldb \
    && chown hsqldb:hsqldb -R /etc/opt/hsqldb

EXPOSE 9001
USER hsqldb
CMD [ "docker-entrypoint.sh" ]