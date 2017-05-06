### FREERADIUS

### Creación de la base de datos, usuario administrador y inserción del esquema principal de radius.

mysql -e "create database radius; \
grant ALL PRIVILEGES ON radius.* TO radius@'%' identified by 'radius'; \
FLUSH PRIVILEGES; \
use radius; \
source /opt/docker/conf_files/schema.sql;" && \

### Esquemas NAS y IPPOOL, para usuarios remotos y dispostivos

mysql -e "use radius; \
source /opt/docker/conf_files/ippool.sql; \
source /opt/docker/conf_files/nas.sql;" && \

### DALORADIUS
### Creacion de la base de datosm usuario administrador y insercion del esquema principal de daloradius.

mysql -e "create database daloradius; \
grant all on daloradius.* TO radiusfree@'192.168.0.4' identified by 'freeradius'; \
use daloradius; \
source /opt/docker/conf_files/fr2-mysql-daloradius-and-freeradius.sql;" && \

### POPULATE
mysql -e "use radius; \
INSERT INTO radcheck (username,attribute,op,value) VALUES('usuario1','password','==','usuario1');"&& \
mysql -e "use radius; \
INSERT INTO nas (nasname, shortname, type, secret) VALUES ('192.168.0.3', 'servidor', 'other', 'radius');" && \

mysql -e "use radius; \
INSERT INTO nas (nasname, shortname, type, secret) VALUES ('192.168.1.3', 'ap_wifi', 'other', 'radius');" && \

exit 0;
