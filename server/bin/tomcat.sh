#!/bin/sh

ACTION=$1 
cd /opt/openbravo/bin/
./tomcat1-1.sh $1
./tomcat1-2.sh $1
./tomcat1-3.sh $1

