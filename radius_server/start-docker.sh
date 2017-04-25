#!/bin/bash

### Script que crea un container a partir de un Dockerfile.
### El fin de este script es probar la creacion de containers a partir
### del dockerfile, con el ir construyendolo e ir elaborando una serie
### de comprobaciones automaticas para saber que todo funciona correctamente


### Docker build apartir de un dockerfile
docker build -t proyecto_final/radius .

### Arrancar container con tiempo de vida limitado
docker run --rm --name radius -id proyecto_final/radius
