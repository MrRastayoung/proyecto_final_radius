#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=ldap

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/ldap"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm --name $CONTAINER_NAME -id $REPOSITORI_IMAGE -p 389 --net network_proyecto_final/radius --ip 172.18.0.5 --link radius:radius -id $REPOSITORI_IMAGE

sleep 4s
clear

### PID DEL SERVICIO
docker exec -it $CONTAINER_NAME /bin/bash -c "ps -ax"
sleep 5s
clear


### ELIMINANDO CONTENEDOR
#/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
