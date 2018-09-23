FROM tomcat:8.0-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

VOLUME /tmp
ADD target/sample.war /usr/local/tomcat/webapps/sample.war
ADD redis-session-manager-with-dependencies-2.2.2-SNAPSHOT.jar /usr/local/tomcat/lib/redis-session-manager-with-dependencies-2.2.2-SNAPSHOT.jar
COPY ./tomcat-conf/my-server.xml /usr/local/tomcat/conf/server.xm


EXPOSE 8080
EXPOSE 8009
