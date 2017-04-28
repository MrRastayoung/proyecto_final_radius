#!/bin/bash

## SCRIPT para insertar las bases de datos y usuarios necesarios para


##
## base de datos radius + mysql
USERDB_ADMIN_RADIUS=radius
USERDB_PASS_RADIUS=radius

# 1 CREATE DB
mysql -uroot -e "CREATE DATABASE tutorial_database; \
		CREATE USER "$USERDB_ADMIN_RADIUS'@'%' IDENTIFIED BY 'radius'; \
		GRANT ALL PRIVILEGES ON * . * TO 'nombre_usuario'@'localhost'; "



## base de datos daloradius + radius + mysql
