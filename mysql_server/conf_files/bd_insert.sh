## base de datos radius

mysql -e "create user 'radius'@'localhost';" && \
mysql -e "create database radius;" && \
mysql -e "grant ALL PRIVILEGES ON radius.* TO radius@'localhos';" && \
mysql -e "use radius; source /opt/docker/conf_files/schema.sql;show tables" && \
mysql -e "use radius; INSERT INTO radcheck (username,attribute,op,value) VALUES('usuario1','password','==','usuario1');"

### populate 

## esquemas necesarios radius + mysql

