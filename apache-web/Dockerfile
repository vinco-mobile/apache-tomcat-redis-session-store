FROM httpd:2.4-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

# Copy configuration
#COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./my-virtualhost.conf /usr/local/apache2/conf/my-virtualhost.conf
# Copy static web
COPY ./public-html/ /usr/local/apache2/htdocs/

EXPOSE 80
