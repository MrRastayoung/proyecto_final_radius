#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=ldap

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/ldap"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm --name $CONTAINER_NAME -id $REPOSITORI_IMAGE 

### PID DEL SERVICIO
#docker exec -it $CONTAINER_NAME ps -ax

### ELIMINANDO CONTENEDOR
#/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
