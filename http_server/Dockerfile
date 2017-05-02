FROM resin/rpi-raspbian
MAINTAINER " Altair version 0.1

RUN \ 
 apt-get update && \
 apt-get install apache2 \
 vim \
 php5 \
 php-pear \
 php5-mysql


COPY conf_files/apache2.conf /etc/apache2/
COPY conf_files/mpm_prefork.conf /etc/apache2/mods-available/
RUN sudo a2dismod mpm_event
RUN sudo a2enmod mpm_prefork

RUN mkdir -p /var/www/html/zion.com/public_html 
RUN sudo mkdir /var/www/html/zion.com/logs
COPY conf_files/zion.com.conf /etc/apache2/sites-available/
RUN sudo a2ensite zion.com.conf 
COPY conf_files/php.ini /etc/php5/apache2/
RUN mkdir /var/log/php 
RUN chown www-data /var/log/php

RUN sudo service apache2 restart

ENTRYPOINT ["/bin/bash"]
