FROM armv7/armhf-fedora

MAINTAINER "Altair version 0.1 LDAP"

### CONF FILES

RUN mkdir /opt/docker
COPY conf_files/LDAP /opt/docker


RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-24-armhfp
RUN dnf update -y

RUN dnf install -y -q \ 
openldap-servers \
openldap-clients \
procps \
vim \
wget \
nmap 
 
RUN dnf clean all 

RUN wget http://open.rhx.it/phamm/schema/radius.schema ; mv radius.schema /etc/openldap/schema

COPY conf_files /opt/docker
RUN chmod 755 /opt/docker/startup.sh ; /opt/docker/startup.sh

EXPOSE 389 636

#CMD slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats
#ENTRYPOINT slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats && /bin/bash
ENTRYPOINT /usr/sbin/slapd -u ldap -h "ldap:/// ldaps:/// ldapi:///" -u ldap & /bin/bash


## [LDAP ](https://alex02.wordpress.com/2014/12/12/proyecto-v2-0-parte-2-instalacion-y-configuracion-del-servidor-openldap-en-debian-wheezy/)
