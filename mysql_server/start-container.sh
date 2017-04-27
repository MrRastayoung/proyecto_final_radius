#!/bin/bash

# Nombre que queremos que tenga el container
CONTAINER_NAME=mysql

# Imagen que utilizaremos ( imagen creada con docker file )
REPOSITORI_IMAGE="proyecto_final/mysql"

### Arrancar container con tiempo de vida limitado
docker run --rm --name $CONTAINER_NAME -id $REPOSITORI_IMAGE /bin/bash
