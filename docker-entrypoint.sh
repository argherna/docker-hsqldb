#!/bin/bash

# -----------------------------------------------------------------------------
#
# docker-entrypoint.sh
#
# Initializes an hsqldb database and then starts it as a server in the 
# foreground.
#
# FILES
#
#     /opt/hsqldb/lib/hsqldb.jar     Main jar file for HSQLDB.
#
#     /opt/hsqldb/lib/sqltool.jar    CLI tool for managing datbases.
#
#     /opt/hsqldb/lib/log4j.jar      Logging library.
#
#     /etc/hsqldb/conf               Directory for configuration files.
#
#     /etc/hsqldb/conf/server.properties
#             Configuration file for the hsqldb server.
#
#     /etc/hsqldb/conf/sqltool.rc   Configuration file for sqltool.
#
#     /var/hsqldb/sql/init-db0.sql  Initial database load/commands.
#
# -----------------------------------------------------------------------------

set -e

if [ ! -e /var/opt/hsqldb/run/init-db0.lck ]; then
  java -jar /opt/hsqldb/lib/sqltool.jar \
    --rcFile=/etc/opt/hsqldb/conf/sqltool.rc \
    initdb0 \
    /var/opt/hsqldb/sql/init-db0.sql
  touch /var/opt/hsqldb/run/init-db0.lck
fi

CLASSPATH="/opt/hsqldb/lib/*"
CLASSPATH="$CLASSPATH:/etc/hsqldb/conf"
exec java -cp $CLASSPATH \
  org.hsqldb.server.Server \
  --props /etc/opt/hsqldb/conf/server.properties
