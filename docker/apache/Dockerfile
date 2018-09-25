FROM httpd:2.4-alpine
MAINTAINER Tomas Couso tomas.couso@enzymeadvisinggroup.com

# Copy configuration
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./public-html/ /usr/local/apache2/htdocs/

EXPOSE 80
