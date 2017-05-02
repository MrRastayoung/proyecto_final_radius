___Servidor LAMP " Linux Apache Mysql Php "___

__Instalación y configuracion de un servidor LAMP en Raspberry utilizando
Raspbian__

# Apache

## Apache: Instalar y configurar.

### 1. Instalar Apache 2:

	1. sudo apt-get install apache2

### 2. Editar la configuración principal de Apache:

	Fichero: **/etc/apache2/apache2.conf**
	
	1. KeepAlive Off
	
### 3. Opimización del modulo multiprocesamiento:

	NOTA: __Optimización de 512MB, optimizar según convenga personalmente__ .
	
	Fichero: **/etc/apache/mods-available/mpm_prefork.conf** .

	``
	# prefork MPM
	# StartServers: number of server processes to start
	# MinSpareServers: minimum number of server processes which are kept spare
	# MaxSpareServers: maximum number of server processes which are kept spare
	# MaxRequestWorkers: maximum number of server processes allowed to start
	# MaxConnectionsPerChild: maximum number of requests a server process serves

	<IfModule mpm_prefork_module>
			StartServers                     1
			MinSpareServers           5
			MaxSpareServers          10
			MaxRequestWorkers         50
			MaxConnectionsPerChild   1120
	</IfModule>

	# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
	``

### 4. Desactivar modulo event y activar prefork:

	1. sudo a2dismod mpm_event
	2. sudo a2enmod mpm_prefork

### 5. Reiniciar Apache:

	1. sudo service apache2 restart

## Configurar VirtualHost basado en nombre.

### 1. Crear directorios donde alojar el sitio web y los logs pertenecientes:

	1. sudo mkdir -p /var/www/html/zion.com/public_html
	2. sudo mkdir /var/www/html/zion.com/logs

### 2. Crear fichero zion.com.conf en **/etc/apache2/sites-available**:

	Fichero: **/etc/apache2/sites-available/zion.com.conf**
	
	``
	<VirtualHost *:80>
	ServerAdmin webmaster@zion.com
	ServerName zion.com
	ServerAlias www.zion.com
	DocumentRoot /var/www/html/zion.com/public_html/
	ErrorLog /var/www/html/zion.com/logs/error.log
	CustomLog /var/www/html/zion.com/logs/access.log combined
	</VirtualHost>

	``

### 3. Crear enlace simbolico para activar el VirtualHost:

	1. sudo a2ensite zion.com.conf
	
	NOTA: __Para deshabilitar un sitio web__ ``sudo a2disite zion.com``.

### 4. Reiniciar Apache:

	1. sudo service apache2 restart

## Implementación de Mysql.

### 1. Instalar MySQL:

	1. sudo apt-get install mysql-server
	
	NOTA: __Según la instalación puede que nos pida un password, este
	será para el usuario administrador con permisos totales sobre las bases de datos,
	si la instalación se hace en un entorno "noninteractive" lo más provable es, que 
	no nos pida la contraseña...__

### 2. Ejecutar ``mysql_secure_installation`` para eliminar restos inecesarios de datos de la instalación ( BD, permisos, etc):
	
	1. sudo mysql_secure_installation
	
	NOTA: __Es recomendable aceptar todo con "yes/si" en todo lo que se nos pida__.
	
## Iniciar base de datos MySQL.

Lo siguiente que haremos, será crear  una base de datos y otorgar los permisos 
correctos a un usuario determinado para que pueda administrar esa base de datos sin problemas.

### 1. Acceder a Mysql:

	NOTA: __ Si el usuario administrador tiene **password** ``-p``,
	si el usuario administrador no tiene contraseña "**MAL**", no usaremos la opción ``-p``.
	__Que el usuario administrador no tenga contraseña en un entorno en producción y expuesto
	podria ser un desastre para nuestra organización.__
	
	1. sudo mysql -uroot -p
	
### 2. Crear la base de datos y otorgar permisos al usuario administrador de esa base de datos:

	NOTA: __ Estaremos en el prompt de ``mysql>``__.

	1. create database webdata;
	2. gran all on webdata.* to 'altair' identified by 'ZAaAJ1989-2017';
	
### 3. Salir de MySQL:

	1 quit

## PHP

Php nos facilitara poder crear páginas web dinámicas e interactivas utilizando 
nuestros propios scripts y cualquier **framwork** de desarollo.

### 1. Instalar PHP5 y Extensiones:

	1. sudo apt-get install php5 php-pear
	
### 2. Abrir ``/etc/php5/apache2/php.ini`` y editar los siguientes valores.

	NOTA: __Los valores estan optimizados a 512MB igual que Apache, si requerimos
	de una configuración personalizada deveremos ajustar los valores, para que se adecuen
	a la configuración más optima de nuestro servidor__
	
	Fichero: **/etc/php5/apache2/php.ini**

	``
	error_reporting = E_COMPILE_ERROR|E_RECOVERABLE_ERROR|E_ERROR|E_CORE_ERROR
	error_log = /var/log/php/error.log  
	max_input_time = 30
	``

### 3. Directorio de logs para PHP5.
	
	NOTA: __Crearemos un directorio y haremos propietario al usuario que maneja el servicio de apache2__.
	
	1. sudo mkdir /var/log/php
	2. sudo chown www-data /var/log/php

### 4. Soporte de MySQL para PHP.

	1. sudo apt-get install php5-mysql

### 5. Reiniciar Apache:

	1. sudo service apache2 restart



## Daloradius

Frontend con el que podremos administrar freeradius basado en msyql.

### 1. Daloradius instalar y configurar:

	NOTA: __Instalaremos paquetes necesarios en el caso que no esten instalados en nuestro sistema__.

	1. sudo apt-get install 

### 2. Descargar Daloradius:
	1. wget http://sourceforge.net/projects/daloradius/files/daloradius/daloradius0.9-9/daloradius-0.9-9.tar.gz
	2. tar zxvf daloradius-0.9-9.tar.gz

### 3. Importart los esquemas a la base de datos de **radius**:

	NOTA: __Nos conectaremos al servidor de base de datos para añadir los esquemas de daloradius atentos 
	con las conexiones, y como se definio el usuario administrador de la base de datos, nos podría dar problemas__.

	1. mysql -uradius -p radius < daloradius-0.9-9/contrib/db/fr2-mysql-daloradius-and-freeradius.sql

### 4. Configurar el usuario y password de la base de datos de radius en daloradius:
	
	Fichero: **daloradius-0.9-9/library/daloradius.conf.php**

	``
	$configValues['CONFIG_DB_ENGINE'] = 'mysql';
	$configValues['CONFIG_DB_HOST'] = '172.18.0.2';
	$configValues['CONFIG_DB_PORT'] = '3306';
	$configValues['CONFIG_DB_USER'] = 'radius';
	$configValues['CONFIG_DB_PASS'] = 'radius';
	$configValues['CONFIG_DB_NAME'] = 'radius';
	``

### 5. Publicar Daloradius:

	NOTA: __ Moveremos de lugar el directorio que hemos obtenido despues de descomprimir el paquete de Daloradius,
	por tal de ponerlo en el directorio apropiado de nuestro servidor web__.

	1. sudo mv daloradius-0.9-9 /var/www/html/daloradius

	INFO: __ Podemos instalar __ **phpmyadmin** __ eligiendo apache2 como servidor web, y elegir__ **NO** 
	__si nos pregunta a cerca  de configurar alguna base de datos...__.


### 6. Comprobando el funcionamiento:

	1. http://172.18.0.4/daloradius
	2. http://zion.com/daloradius

	INFO: __El usuario y la contraseña de acceso es__ **administrator** y **radius**

INFO: [Apache Multiprocesamiento](http://www.vozidea.com/diferencias-entre-apache-prefork-event-worker)
INFO: [LAMP Server](https://www.linode.com/docs/web-servers/lamp/lamp-on-debian-8-jessie)

