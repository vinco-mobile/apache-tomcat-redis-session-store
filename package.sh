#!/usr/bin/env bash

mvn clean package
cp sample/target/sample.war ./docker/common/

