#!/bin/bash
# Descargar paquete
/bin/echo "Descargando paquete...."
wget --quiet http://sourceforge.net/projects/daloradius/files/daloradius/daloradius0.9-9/daloradius-0.9-9.tar.gz

# Descomprimir
/bin/echo "Descomprimiendo"
tar zxf daloradius-0.9-9.tar.gz
mv daloradius-0.9-9 /var/www/html/daloradius

clear

# Permisos para el frontend
sudo chown www-data:www-data /var/www/html/daloradius -R
sudo chmod 644 /var/www/html/daloradius/library/daloradius.conf.php



# MYSQL insertar esquema
mysql -h 172.18.0.2 -uradiusfree -pfreeradius daloradius < /var/www/html/daloradius/contrib/db/fr2-mysql-daloradius-and-freeradius.sql


