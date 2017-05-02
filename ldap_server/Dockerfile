FROM resin/rpi-raspbian

MAINTAINER "Altair version 0.1 LDAP"

### CONF FILES

RUN mkdir /opt/docker
COPY conf_files /opt/docker

RUN \ 
apt-get update && \ 
apt-get install -y -qq \ 
slapd \ 
ldap-utils \ 
vim && \ 
rm -rf /var/lib/apt/lists/* 

EXPOSE 389

CMD slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats

#ENTRYPOINT slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats && /bin/bash

ENTRYPOINT /bin/bash
