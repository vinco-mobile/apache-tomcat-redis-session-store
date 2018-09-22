FROM tomcat:8.0-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

# Create base folder
RUN mkdir -p /opt/openbravo
# Copy scripts folder
COPY server /opt/openbravo

# Install Redis
RUN apk update
RUN apk add redis
# Arrancando servidor redis
RUN redis-server --daemonize yes

# Install apache 2
RUN apk add apache2
# Start Apache
RUN rc-update add apache2

EXPOSE 8080
