#!/bin/bash

## Nombre que queremos que tenga el container
CONTAINER_NAME=mysql
## Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/mysql"

mkdir -p /opt/mysql/data
#chcon -Rt svirt_sandbox_file_t /opt/mysql/data

#################################################

/bin/echo "Arrancando container en BACKGROUND"
#docker run --rm --name $CONTAINER_NAME -id $REPOSITORI_IMAGE -v /opt/mysql/data:/var/lib/mysql 
docker run --rm --name $CONTAINER_NAME -p 3306:3306 --net network_proyecto_final/radius --ip 172.18.0.2 -id $REPOSITORI_IMAGE -v /opt/mysql/data:/var/lib/mysql
sleep 10s
clear
#################################################

/bin/echo "Logs mientras arranca el container"
docker logs $CONTAINER_NAME --tail=all 
sleep 7s
clear
#################################################

/bin/echo "Procesos container"
docker exec -it $CONTAINER_NAME ps -ax
sleep 5s
clear
#################################################

/bin/echo "Mostrar bases de datos Principales" 
docker exec -it $CONTAINER_NAME mysql -uroot -e "show databases;"
sleep 10s
clear
#################################################

#/bin/echo "Insertando Base de datos"
#docker exec -it $CONTAINER_NAME bash /opt/docker/insert_bd.sh
#sleep 4s
#clear
#################################################

/bin/echo "Seleccionando la base de datos insertada"
docker exec -it $CONTAINER_NAME mysql -uroot -e "use radius;select * from radcheck;"
sleep 5s
clear
#################################################

/bin/echo "Eliminando container"
#docker stop mysql

