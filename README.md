### hsqldb-img

A Docker image of an HSQLDB server. This image includes:

- hsqdldb.jar
- log4j.jar
- sqltool.jar

Image exposes the standard port 9001 for running HSQLDB.

#### Usage

1. Pull the image from [Docker Hub](https://hub.docker.com/r/agherna/hsqldb/):
       
       docker pull agherna/hsqldb

1. Run the image.

       docker run -p 9001:9001 hsqldb
       
#### Building

1. Edit the following files:
   - `conf/log4j.properties`
   - `conf/server.properties`
   - `conf/sqltool.rc`
1. Include any SQL to initialize the database on build in `sql/init-db0.sql`.
1. Run the build:

       docker build . -t hsqldb
       
1. Run the image:

       docker run -p 9001:9001 hsqldb

Image will run in the foreground and logging is directed to `stdout` by default. 

#### See Also

- [HSQDLB Home](http://hsqldb.org)
- [Docker Hub Repository](https://hub.docker.com/r/agherna/hsqldb/)