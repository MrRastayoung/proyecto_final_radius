#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME="ldap"
CONTAINER_HOSTNAME="ldap"
# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/ldap"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"

docker run --rm --name $CONTAINER_NAME --hostname $CONTAINER_HOSTNAME -p 389:389 -p 636:636 --net network_proyecto_final/radius --ip 192.168.0.5 --link radius:radius -id $REPOSITORI_IMAGE

sleep 4s
clear

### PID DEL SERVICIO
docker exec -it $CONTAINER_NAME  ps -ax 
sleep 5s
clear


### ELIMINANDO CONTENEDOR
#/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
