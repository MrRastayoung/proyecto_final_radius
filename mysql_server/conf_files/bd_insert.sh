## base de datos radius

mysql -e "create database radius;" && \
mysql -e "create user 'radius'@'%';" && \
mysql -e "grant ALL PRIVILEGES ON radius.* TO radius@'%' identified by 'radius'; FLUSH PRIVILEGES;" && \
mysql -e "use radius; source /opt/docker/conf_files/schema.sql;" && \
mysql -e "use radius; INSERT INTO radcheck (username,attribute,op,value) VALUES('usuario1','password','==','usuario1');" && \

mysql -e "use radius; source /opt/docker/conf_files/ippool.sql;" && \

mysql -e "use radius; source /opt/docker/conf_files/nas.sql;" && \
mysql -e "use radius; INSERT INTO nas (nasname, shortname, type, secret) VALUES ('172.18.0.3', 'servidor', 'other', 'radius');" && \


### populate 

## esquemas necesarios radius + mysql
exit 0;
