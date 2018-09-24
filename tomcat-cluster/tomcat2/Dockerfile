FROM tomcat:8.0-jre8-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

VOLUME /tmp
ADD sample.war /usr/local/tomcat/webapps/sample.war
ADD redis-session-manager-with-dependencies-2.2.2-SNAPSHOT.jar /usr/local/tomcat/lib/redis-session-manager-with-dependencies-2.2.2-SNAPSHOT.jar
COPY ./conf/my-server.xml /usr/local/tomcat/conf/server.xml


EXPOSE 8080
EXPOSE 8009
