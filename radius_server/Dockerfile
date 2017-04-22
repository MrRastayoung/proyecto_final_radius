# Altair Fernández Castro
# Proyecto final Administración de sistemas operativos en red
# Servidor Radius autenticacion LDAP + Kerberos, segurizada con certificados
# personalizados TLS, incorporación de un servidor web con los frontends
# destinados a la administración o conexion de los servicios posibles tales como,
# Daloradius, PhpMyadmin ( si se da el caso ), PhpLdapadmin, HotSpot

## Imagen que se utilizara 
FROM resin/rpi-raspbian

## Persona responsable del docker
MAINTAINER "Altair version: 01"

## Actualizar repositorios e instalar paquetes necesarios
RUN apt-get update
RUN apt-get install freeradius freeradius-utils

## Directorios  
RUN mkdir /opt/docker

# Ficheros INFO AND PROFILE
#COPY ../.* /opt/docker/
#COPY ../bash_profile /root/.bash_profile

# Ficheros CONF
#COPY ../users /etc/freeradius/
#COPY ../radiusd.conf /etc/freeradius/

CMD ["/bin/bash"]
EXPOSE 1812

