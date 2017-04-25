# Altair Fernández Castro
# Proyecto final Administración de sistemas operativos en red
# Servidor Radius autenticacion LDAP + Kerberos, segurizada con certificados
# personalizados TLS, incorporación de un servidor web con los frontends
# destinados a la administración o conexion de los servicios posibles tales como,
# Daloradius, PhpMyadmin ( si se da el caso ), PhpLdapadmin, HotSpot

## Imagen que se utilizara, en este caso el proyecto se monta sobre una raspberry 3 B
FROM resin/rpi-raspbian

## Persona responsable del docker
MAINTAINER "Altair version: 01"

## Actualizar repositorios e instalar paquetes necesarios
RUN apt-get update && apt-get install -y \
    freeradius \
    freeradius-utils \
    locales \
    net-tools \
    nmap \
    vim \
    openssh-server

## Directorios  
RUN mkdir /opt/docker

# Ficheros INFO AND PROFILE
COPY conf_files /opt/docker/

# Ficheros CONF
COPY /opt/docker/conf_files/users /etc/freeradius/
COPY /opt/docker/conf_files/radiusd.conf /etc/freeradius/

## COMANDO QUE SE EJECUTARA CUANDO SE ACABE DE CREAR EL DOCKER
#ENTRYPOINT [“/bin/cat”]

## Comando que se ejecutara al crear el docker
CMD ["/bin/bash"]

ENTRYPOINT /etc/init/freeradius -X & /bin/bash

## Puertos que se mapearan host:docker
EXPOSE 1812 1813

