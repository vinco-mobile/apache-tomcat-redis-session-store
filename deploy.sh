#!/usr/bin/env bash

cp sample/target/sample.war ./docker/common/
cp -rv ./docker/common ./docker/tomcat1/
cp -rv ./docker/common ./docker/tomcat2/
cp -rv ./docker/common ./docker/tomcat3/

cd docker
# Se detiene docker-compouse
docker-compose down
# Se construyen las imagenes
docker-compose build


