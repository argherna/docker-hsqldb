### hsqldb-img

A Docker image of an HSQLDB server. This image includes:

- hsqdldb.jar
- log4j.jar
- sqltool.jar

Image exposes the standard port 9001 for running HSQLDB.

#### Building

1. Edit the following files:
   - `conf/log4j.properties`
   - `conf/server.properties`
   - `conf/sqltool.rc`
1. Include any SQL to initialize the database on build in `sql/init-db0.sql`.
1. Run the build:

       docker build . -t hsqldb


#### See Also

- [HSQDLB Home](http://hsqldb.org)