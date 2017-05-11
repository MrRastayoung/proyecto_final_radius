#!/bin/bash

## Nombre que queremos que tenga el container
CONTAINER_NAME=mysql

## Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/mysql"

## Nombre que tendra el host
CONTAINER_HOSTNAME="mysql"

## Nombre del dominio
DOMAIN_NAME=".zion.com"

mkdir -p /opt/mysql/data
#chcon -Rt svirt_sandbox_file_t /opt/mysql/data

#################################################

/bin/echo "Arrancando container en BACKGROUND"
docker run --rm \
  --name $CONTAINER_NAME \
  --hostname "$CONTAINER_HOSTNAME$DOMAIN_NAME" \
  -p 3306:3306 \
  --net network_proyecto_final/radius \
  --ip 192.168.0.2 -id $REPOSITORI_IMAGE \
  --link radius:radius \
  -v /opt/mysql/data:/var/lib/mysql \
 ||  docker stop $CONTAINER_NAME &&
sleep 3
clear
#################################################

/bin/echo "Logs mientras arranca el container"
docker logs $CONTAINER_NAME --tail=all 
sleep 5
clear
#################################################

/bin/echo "Procesos container"
docker exec -it $CONTAINER_NAME ps -ax
sleep 3
clear
#################################################

/bin/echo "Mostrar bases de datos Principales" 
docker exec -it $CONTAINER_NAME mysql -uroot -e "show databases;"
sleep 5
clear
#################################################

/bin/echo "Seleccionando la base de datos insertada"
docker exec -it $CONTAINER_NAME mysql -uroot -e "use radius; select * from radcheck; select * from nas;"
sleep 5
clear
#################################################

#/bin/echo "Eliminando container"
#docker stop mysql

