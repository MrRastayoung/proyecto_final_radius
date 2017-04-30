#!/bin/bash

## source
#[Limpieza docker](http://www.rqlogic.com/blog/2014/Oct/28/borrar-contenedores-e-imagenes-antiguas-de-docker/)
#limpiar todas las imagenes que no usemos
docker rmi $(docker images | tail -n +2 | awk '$1 == "<none>" {print $'3'}') -f

#limpiar volumnes huerfanos
docker volume rm $(docker volume ls -qf dangling=true) -f
