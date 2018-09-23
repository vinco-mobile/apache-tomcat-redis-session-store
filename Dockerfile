FROM tomcat:8.0-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

# Create base folder
RUN mkdir -p /opt/openbravo/
# Copy scripts folder
COPY server /opt/openbravo/

# Install openrc, apache, apache-proxy
RUN set -x \
    && apk update && apk upgrade \
    && apk add openrc apache2 apache2-proxy apache2-ctl redis

# Copy apache configuration
RUN cp -v /etc/apache2/httpd.conf /etc/apache2/httpd.conf.backup
RUN cp -v /opt/openbravo/web-server/conf/httpd.conf /etc/apache2/

# Start Apache
RUN mkdir /run/apache2 &&  chmod 0710 /run/apache2
RUN rc-update add networking
RUN rc-update add apache2
#RUN cat /etc/apache2/httpd.conf


# Arrancando servidor redis
#RUN redis-server --daemonize yes
RUN rc-update add redis

# Se arancan los servicios

RUN rc-status




# Make scripts executable
RUN chmod +x /opt/openbravo/bin/*.sh

EXPOSE 8181
EXPOSE 8182
EXPOSE 8183
EXPOSE 80
EXPOSE 9000


#CMD /opt/openbravo/bin/tomcat.sh run
CMD bash