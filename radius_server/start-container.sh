#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=radius

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/radius"

### Arrancar container con tiempo de vida limitado
/bin/echo "CREANDO CONTENEDOR"
docker run --rm --name $CONTAINER_NAME -p 1812:1812 -p 1813:1813 --net network_proyecto_final/radius --ip 172.18.0.3 --link mysql:mysql -id $REPOSITORI_IMAGE /bin/bash

### PID DEL SERVICIO
docker exec -it $CONTAINER_NAME ps -ax
### Comando de test 
/bin/echo "Comprobando test 1 usuario local\n"
docker exec -it $CONTAINER_NAME radtest altair testing localhost 1812 testing123

docker exec -it $CONTAINER_NAME radtest usuario1 usuario1 172.18.0.3 1812 testing123

### ELIMINANDO CONTENEDOR
/bin/echo "Eliminando container"
#docker stop $CONTAINER_NAME
