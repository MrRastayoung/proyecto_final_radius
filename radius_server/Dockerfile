# Altair Fernández Castro
# Proyecto final Administración de sistemas operativos en red
# Servidor Radius autenticacion LDAP + Kerberos, segurizada con certificados
# personalizados TLS, incorporación de un servidor web con los frontends
# destinados a la administración o conexion de los servicios posibles tales como,
# Daloradius, PhpMyadmin ( si se da el caso ), PhpLdapadmin, HotSpot

FROM resin/rpi-raspbian

MAINTAINER "Altair version: 0.1"

RUN apt-get update &&\
 apt-get install -qq --auto-remove\
 freeradius\
 freeradius-mysql\
 freeradius-utils \
 iputils-ping \
 nmap \
 net-tools && \
 apt-get clean all; exit 0

RUN mkdir /opt/docker

WORKDIR /opt/docker

COPY conf_files/users /etc/freeradius/
COPY conf_files/radiusd.conf /etc/freeradius/
COPY conf_files/sql.conf /etc/freeradius/sql.conf
COPY conf_files/default /etc/freeradius/
COPY startup.sh /opt/docker/
RUN chmod +x /opt/docker/startup.sh

#COPY conf_files/sql.conf /etc/freeradius/
#COPY conf_files/nas.sql /etc/freeradius/sql/

CMD freeradius -X 

ENTRYPOINT service freeradius start && /bin/bash 

## Puertos que se mapearan host:docker
EXPOSE 1812 1813

# vim:fileencoding=utf8
