#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=radius

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/radius"

# Nombre que tendra el host
CONTAINER_HOSTNAME="radius"
### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm --name $CONTAINER_NAME --hostname $CONTAINER_HOSTNAME -p 1812:1812/udp --net network_proyecto_final/radius --ip 192.168.0.3 --link mysql:mysql -id $REPOSITORI_IMAGE 
sleep 5s
clear

### PID DEL SERVICIO
docker exec -it $CONTAINER_NAME ps -ax
sleep 6s
clear

#docker exec -it $CONTAINER_NAME service freeradius start 

### Comandos de test 
/bin/echo "TEST 1: USUARIO LOCAL, altair:zion testing123 LOCALHOST"
docker exec -it $CONTAINER_NAME radtest altair zion localhost 1812 testing123
sleep 4s
/bin/echo "El test 1 Falla, descomentar en radiusd.conf en seccion authorize: file"

/bin/echo " "

/bin/echo "TEST 2: USUARIO REMOTO MYSQL, usuario1:usuario1 radius 192.168.0.3"
docker exec -it $CONTAINER_NAME radtest usuario1 usuario1 192.168.0.3 1812 radius
sleep 6s
clear

/bin/echo "TEST 3: APWIFI, usuario1:usuario1 radius 192.168.0.10"
docker exec -it $CONTAINER_NAME radtest usuario1 usuario1 192.168.0.10 1812 radius
sleep 6s
clear


### ELIMINANDO CONTENEDOR
#/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
