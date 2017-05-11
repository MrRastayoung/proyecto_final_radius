#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=radius

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/radius"

# Nombre que tendra el host
CONTAINER_HOSTNAME="radius"

# Nombre de dominio
DOMAIN_NAME=".zion.com"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm \
  --name $CONTAINER_NAME \
  --hostname "$CONTAINER_HOSTNAME$DOMAIN_NAME" \
  -p 1812:1812/udp \
  --net network_proyecto_final/radius \
  --ip 192.168.0.3 \
  --link mysql:mysql_server \
  --link ldap:ldap_server \
  -id $REPOSITORI_IMAGE

sleep 3s
clear

### PID DEL SERVICIO
docker exec -it $CONTAINER_NAME ps -ax
sleep 3s
clear

### FREERADIUS SERVICE START    # COMENTAR para debug mode y ejecutar "docker exec -it $CONTAINER_NAME freeradius -X" 
#docker exec -it $CONTAINER_NAME service freeradius start 

### Comandos de test autenticación local y NAS remoto
/bin/echo "TEST 1: AUTENTICACIÓN USUARIO LOCAL, altair:zion testing123 LOCALHOST"
docker exec -it $CONTAINER_NAME radtest altair zion localhost 1812 testing123
sleep 4s
/bin/echo "Si el test 1 Falla, descomentar en radiusd.conf, en seccion authorize: file"

#/bin/echo "TEST 2: ATUTENTICACIÓN DE USUARIO REMOTO en BD MYSQL, usuario1:usuario1 radius 192.168.0.3"
docker exec -it $CONTAINER_NAME radtest usuario1 usuario1 192.168.0.3 1812 radius
#sleep 3s
clear

#/bin/echo "TEST 3: AUTENTICACIÓN DE USUARIO REMOTO en LDAP, usuario1:usuario1 radius 192.168.0.1"
docker exec -it $CONTAINER_NAME radtest altair zionLDAP radius.zion.com 1 radius
#sleep 6s
#clear

### ELIMINANDO CONTENEDOR
#/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
