FROM tomcat:8.0-jre8-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

VOLUME /tmp
ADD ./common/sample.war /usr/local/tomcat/webapps/sample.war
ADD ./common/redisson-all-3.7.5.jar /usr/local/tomcat/lib/
ADD ./common/redisson-tomcat-8-3.7.5.jar /usr/local/tomcat/lib/
COPY ./common/context.xml /usr/local/tomcat/conf/
#COPY common/server.xml /usr/local/tomcat/conf/
COPY ./common/redisson.json /usr/local/tomcat/conf/
RUN  sed -i 's|<Engine name="Catalina" defaultHost="localhost">|<Engine name="Catalina" defaultHost="localhost" jvmRoute="tomcat1">|g' /usr/local/tomcat/conf/server.xml


EXPOSE 8080
EXPOSE 8009
