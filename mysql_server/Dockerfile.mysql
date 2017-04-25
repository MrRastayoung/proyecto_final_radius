FROM resin/rpi-raspbian
MAINTAINER " Altair version 0.1

RUN apt-get update && apt-get install \
    mysql-server \
    freeradius-mysql

# Copiando archivos de configuración
RUN mkdir /opt/docker
COPY conf_files /opt/docker

# Configurando servicio
RUN cp /opt/docker/conf_files/

## Puertos que se mapearan host:docker
EXPOSE 1812 1813

## Comando que se ejecutara al crear el docker
CMD ["/bin/bash"]

