#!/bin/bash

INSTANCE=$1
CMD=$2

export JRE_HOME=/usr
export CLASSPATH=/usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar
export CATALINA_PID=/opt/openbravo/app-server/instance1-1/temp/tomcat.pid
export CATALINA_HOME=/usr/local/tomcat
export CATALINA_BASE=/opt/openbravo/app_server/instance1-$INSTANCE
export CATALINA_OUT=/opt/openbravo/logs/tomcat1-$INSTANCE/catalina.out



$CATALINA_BASE/bin/catalina.sh $CMD
