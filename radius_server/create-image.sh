#!/bin/bash

### Script que crea un container a partir de un Dockerfile.
### El fin de este script es probar la creacion de imagenes a partir
### de un dockerfile.
### Con el, ir construyendo y elaborando una serie
### de comprobaciones automaticas para saber que todo funciona correctamente

REPOSITORI_IMAGE="proyecto_final/radius"

### Docker build apartir de un dockerfile
docker build -t $REPOSITORI_IMAGE .
