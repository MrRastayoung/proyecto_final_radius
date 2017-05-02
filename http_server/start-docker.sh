#!/bin/bash

### Script que crea un container a partir de un Dockerfile.
### El fin de este script es probar la creacion de containers a partir
### del dockerfile, con el ir construyendolo e ir elaborando una serie
### de comprobaciones automaticas para saber que todo funciona correctamente

# Nombre que queremos que tenga el container
CONTAINER_NAME=http

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/http"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm --name $CONTAINER_NAME -p 80:80 -p 443:443 --net network_proyecto_final/radius --ip 172.18.0.4 --link mysql:mysql -id $REPOSITORI_IMAGE 
sleep 5s
clear


docker exec -it $CONTAINER_NAME ps -ax
sleep 5s
clear
