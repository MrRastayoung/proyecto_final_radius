FROM resin/rpi-raspbian
MAINTAINER " Altair version 0.1

RUN export TERM=dumb

RUN \ 
 apt-get update && \
 apt-get install -y -qq \
 apt-utils \
 vim \
 wget \ 
 mysql-client \
 apache2 \
 php5 \
 php-pear \
 php5-mysql


RUN mkdir -p /opt/docker

COPY conf_files/apache2.conf /etc/apache2/
COPY conf_files/mpm_prefork.conf /etc/apache2/mods-available/
COPY conf_files/install_daloradius.sh /opt/docker/
RUN sudo a2dismod mpm_event
RUN sudo a2enmod mpm_prefork

RUN mkdir -p /var/www/html/zion.com/public_html 
RUN sudo mkdir /var/www/html/zion.com/logs
COPY conf_files/zion.com.conf /etc/apache2/sites-available/
RUN sudo a2ensite zion.com.conf 
COPY conf_files/php.ini /etc/php5/apache2/
RUN mkdir /var/log/php 
RUN chown www-data /var/log/php

RUN chmod +x /opt/docker/install_daloradius.sh

RUN /bin/bash -c "/opt/docker/install_daloradius.sh"

EXPOSE 80 443

ENTRYPOINT service apache2 start && /bin/bash

CMD ["apachectl -S"]
