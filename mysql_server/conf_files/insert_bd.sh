#!/bin/bash
## SCRIPT para insertar las bases de datos y usuarios necesarios para
##
## base de datos radius + mysql
USERDB_ADMIN_RADIUS=radius
USERDB_PASS_RADIUS=radius
DATTABASE_NAME=radius



mysql -uroot -e "CREATE DATABASE radius; CREATE USER 'radius'@'%' IDENTIFIED BY 'radius'; GRANT ALL PRIVILEGES ON * . * TO 'radius'@'localhost'; "
