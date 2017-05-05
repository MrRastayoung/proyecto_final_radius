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
 vim \ 
 net-tools \
 openssh-server && \
 apt-get clean all; exit 0

RUN mkdir /opt/docker

WORKDIR /opt/docker

COPY conf_files/eap.conf /etc/freeradius/
COPY conf_files/users /etc/freeradius/
COPY conf_files/clients.conf /etc/freeradius/
COPY conf_files/ldap /etc/freeradius/modules/
COPY conf_files/inner-eap /etc/freeradius/modules/

COPY conf_files/radiusd.conf /etc/freeradius/
COPY conf_files/sql.conf /etc/freeradius/sql.conf
COPY conf_files/default /etc/freeradius/sites-available/
COPY conf_files/inner-tunnel /etc/freeradius/sites-available

COPY conf_files/CERTS_TLS_RADIUS /opt/docker/CERTS_TLS_RADIUS

RUN chmod 644 -R /opt/docker/CERTS_TLS_RADIUS ; chown root:freerad -R /opt/docker/CERTS_TLS_RADIUS

RUN \
rm -rf /etc/freeradius/certs/ca.pem ;\
cp /opt/docker/CERTS_TLS_RADIUS/ROOT_CA/ca.pem /etc/freeradius/certs/ ;\
cp /opt/docker/CERTS_TLS_RADIUS/CERTIFICATES_CSR/server.key /etc/freeradius/certs/ ;\
cp /opt/docker/CERTS_TLS_RADIUS/CERTIFICADO_FIRMADO/server.crt /etc/freeradius/certs/

RUN \
cp /opt/docker/CERTS_TLS_RADIUS/CERTS_INNER_EAP/server-inner.pem /etc/freeradius/certs/server-inner.key ;\
cp /opt/docker/CERTS_TLS_RADIUS/CERTS_INNER_EAP/server-inner.crt /etc/freeradius/certs/

ADD conf_files/startup.sh /startup.sh

RUN chmod +x /startup.sh


ENTRYPOINT ["/startup.sh"]

## Puertos que se mapearan host:docker
EXPOSE 1812/udp 1813

# vim:fileencoding=utf8 ts=4 sw=4 sts=4 sr noet
