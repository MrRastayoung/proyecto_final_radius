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
    net-tools \
    openssh-server

## Directorios interno
RUN mkdir /opt/docker

# Copiamos archivos desde fuera adentro del docker ( COPY )
COPY conf_files /opt/docker/

# Ficheros CONF trabajamos desde dentro del docker ( RUN )
RUN cp /opt/docker/conf_files/users /etc/freeradius/


## COMANDO QUE SE EJECUTARA CUANDO SE ACABE DE CREAR EL DOCKER
#ENTRYPOINT ["/"]

## Comando que se ejecutara al crear el docker
CMD ["/bin/bash"]

ENTRYPOINT /etc/init/freeradius -X & /bin/bash

## Puertos que se mapearan host:docker
EXPOSE 1812 1813

