#FreeRadius Server on Debian for Raspberry RaspBian

----------------------------
	USERS PASS AND SERVICES
----------------------------
mysql	root	myjupiter
----------------------------
unix	root	jupiter
----------------------------
radius  altair	testing
----------------------------
radius+mysql	usuario1	usuario1
----------------------------


##FreeRadius Server Standalone

Instalación

Actualizacion de de paquetes
	apt-get update

Instalar freeradius
	apt-get install freeradius freeradius-utils

	Observamos que el proceso de instalación actualizara la configuracion de los certificados SSL,
		añadiendo un usuario freerad al grupo de ssl-cert.
		Generar parametro Diffie Helman
		
	``
		Updating default SSL certificate settings, if any...
		Adding user freerad to group ssl-cert
		Generating DH parameters, 1024 bit long safe prime, generator 2
		This is going to take a long time
		................................+.......................................
		...+...........+.........+..............................................
		...................................+...............................+....
		.............+..........................................................
		.........+.............+.......................+........................
		...................................................+....................
		......+.................................................................
		.....................+.....+............................................
		...+.........+..........................................................
		......................+.................................................
		...................................+...+................................
		..........................................................+......+......
		..............................................+.........................
		...............+........................................................
		...................+....................+...............................
		..........+.............+.............................................+.
		......+......................................................+..........
		............................++*++*++*
	``

Configuración del servidor freeradius

Añadir un usuario
	cd /etc/freeradius
	vim users
	
	Devemos buscar la seccion que descrive una entrada de usuario para "STEVE", 
	lo que haremos es crear un usuario para comprobar que el servidor funciona 
	y hace una autenticación simple.
	
	``
		# This is a complete entry for "steve". Note that there is no Fall-Through
		# entry so that no DEFAULT entry will be used, and the user will NOT
		# get any attributes in addition to the ones listed here.
		#
		altair  Cleartext-Password := "testing"
		#       Service-Type = Framed-User,
		#       Framed-Protocol = PPP,
		#       Framed-IP-Address = 172.16.3.33,
		#       Framed-IP-Netmask = 255.255.255.0,
		#       Framed-Routing = Broadcast-Listen,
		#       Framed-Filter-Id = "std.ppp",
		#       Framed-MTU = 1500,
		#	Framed-Compression = Van-Jacobsen-TCP-IP
	``

Reiniciamos el servidor 
	service freeradius restart
	
	``
		[ ok ] Stopping FreeRADIUS daemon: freeradius/var/run/freeradius/freeradius.pid not found....
		[ ok ] Starting FreeRADIUS daemon: freeradius.
	``
Comprobamos el funcionamiento
	radtest altair testing 127.0.0.1 1812 testing123
	
	Si todo esta correcto nos mostrara una respuesta como esta ( ACCESS-ACCEPT )
	``
		Sending Access-Request of id 102 to 127.0.0.1 port 1812
		User-Name = "altair"
		User-Password = "testing"
		NAS-IP-Address = 172.17.0.4
		NAS-Port = 1812
		Message-Authenticator = 0x00000000000000000000000000000000
		rad_recv: Access-Accept packet from host 127.0.0.1 port 1812, id=102, length=20
	``

Hasta aqui tenemos un servidor freeradius muy basico, este no es nuestro objetivo.
Ahora implementaremos la autentificación de los usuarios de una base de datos.
Podemos omitir los primeros pasos, "instalación, configuración y test" 
para seguir con la implementacion de MySql como servidor de BD, 
pero recomiendo leerlo almenos para instalar los paquetes necesarios.


##FreeRadius Server + Mysql

Instalación

Actualizar paquetes
	apt-get update
	
Instalar freeradius y mysql
	apt-get install freeradius freeradius-utils mysql-server freeradius-mysql
	
		Observamos que el proceso de instalación actualizara la configuracion de los certificados SSL,
		añadiendo un usuario freerad al grupo de ssl-cert.
		Generar parametro Diffie Helman
		
	``
		Updating default SSL certificate settings, if any...
		Adding user freerad to group ssl-cert
		Generating DH parameters, 1024 bit long safe prime, generator 2
		This is going to take a long time
		................................+.......................................
		...+...........+.........+..............................................
		...................................+...............................+....
		.............+..........................................................
		.........+.............+.......................+........................
		...................................................+....................
		......+.................................................................
		.....................+.....+............................................
		...+.........+..........................................................
		......................+.................................................
		...................................+...+................................
		..........................................................+......+......
		..............................................+.........................
		...............+........................................................
		...................+....................+...............................
		..........+.............+.............................................+.
		......+......................................................+..........
		............................++*++*++*
	``
Configuración del servidor freeradius

Añadir un usuario
	cd /etc/freeradius
	vim users
	
	Devemos buscar la seccion que descrive una entrada de usuario para "STEVE", 
	lo que haremos es crear un usuario para comprobar que el servidor funciona 
	y hace una autenticación simple.
	
	``
		# This is a complete entry for "steve". Note that there is no Fall-Through
		# entry so that no DEFAULT entry will be used, and the user will NOT
		# get any attributes in addition to the ones listed here.
		#
		altair  Cleartext-Password := "testing"
		#       Service-Type = Framed-User,
		#       Framed-Protocol = PPP,
		#       Framed-IP-Address = 172.16.3.33,
		#       Framed-IP-Netmask = 255.255.255.0,
		#       Framed-Routing = Broadcast-Listen,
		#       Framed-Filter-Id = "std.ppp",
		#       Framed-MTU = 1500,
		#	Framed-Compression = Van-Jacobsen-TCP-IP
	``

Reiniciamos el servidor 
	service freeradius restart
	
	``
		[ ok ] Stopping FreeRADIUS daemon: freeradius/var/run/freeradius/freeradius.pid not found....
		[ ok ] Starting FreeRADIUS daemon: freeradius.
	``
Comprobamos el funcionamiento
	radtest altair testing 127.0.0.1 1812 testing123
	
	Si todo esta correcto nos mostrara una respuesta como esta ( ACCESS-ACCEPT )
	
	``
		Sending Access-Request of id 102 to 127.0.0.1 port 1812
		User-Name = "altair"
		User-Password = "testing"
		NAS-IP-Address = 172.17.0.4
		NAS-Port = 1812
		Message-Authenticator = 0x00000000000000000000000000000000
		rad_recv: Access-Accept packet from host 127.0.0.1 port 1812, id=102, length=20
	``
Implementación del servidor Mysql
	Vamos a configurar freeradius para que utilice un servidor de base de datos para la autenticación.
	Descomentaremos la linia que hace referencia al include sql.
	
	vim radiusd.conf
	
	``
		$INCLUDE sql.conf

	``
Configuración del de mysql
	Nos dirigiremos al directorio sql/mysql y listaremos el contenido
	
	cd sql/mysql
	ls -l
	
	El fichero que nos interesa es " schema.sql "

Acceder a mysql para crear la BD de radius y el usuario 

	mysql -u root -p

	mysql> create database radius;
	``
		gran all on radius.* to radius@localhost identified by 'radius';
	``
	
	mysql> grant all on radius.* to radius@localhost identified by 'radius';
	``
		Query OK, 0 rows affected (0.00 sec)
	``
	
Cambio de de base de datos y creacion de tablas ( schema.sql )
	
	mysql> use radius
	``
		Database changed
	``
	
	mysql> source schema.sql
	``
		Query OK, 0 rows affected (0.02 sec)
		Query OK, 0 rows affected (0.01 sec)
		Query OK, 0 rows affected (0.03 sec)
		Query OK, 0 rows affected (0.02 sec)
		Query OK, 0 rows affected (0.01 sec)
		Query OK, 0 rows affected (0.02 sec)
		Query OK, 0 rows affected (0.01 sec)
	``

	Comprobamos que las tablas se crearon correctamente
	
	mysql> show tables;
	``
		+------------------+
		| Tables_in_radius |
		+------------------+
		| radacct          |
		| radcheck         |
		| radgroupcheck    |
		| radgroupreply    |
		| radpostauth      |
		| radreply         |
		| radusergroup     |
		+------------------+
		7 rows in set (0.01 sec)
	``

Información de la conexion radius y mysql
	
	Salimos de mysql y nos dirigimos al directorio principal de freeradius 
	editaremos el fichero " sql.conf ", para modificar la informacón de 
	acceso de radius hacia mysql, modificando los valores pertenecientes
	al nombre de la bd, usuario y password de acceso, dirección del servidor
	y puerto entre otros datos, de momento nos centraremos en los siguientes.
	
	mysql> quit

	cd /etc/freeradius
	
	vim sql.conf
	``
		# Connection info:
		server = "localhost"
		#port = 3306
		login = "radius"
		password = "radius"
	``

Permitiendo consultas SQL

	Editaremos el fichero " default " del directorio " sites-available",
	para permitir consultas "authorization y accounting" en sus respectivas 
	secciones descomentaremos " sql "
	
	cd sites-available
	vim default
	
	``
		#  Look in an SQL database.  The schema of the database
        #  is meant to mirror the "users" file.
        #
        #  See "Authorization Queries" in sql.conf
        sql
	
	    #  Log traffic to an SQL database.
        #
        #  See "Accounting queries" in sql.conf
        sql
	``
	
	Bien ahora ya tenemos radius conectado a mysql, pero no tenemos
	usuarios en nuestra bd de mysql así que los añadiremos.
	
Añadiendo usuarios
	
	Los usuarios se deven añadir en la tabla " radcheck " de la bd de radius.
	Ingresamos a la base de datos de radius observaremos la tabla radcheck 
	y sus campos y añadiremos un usuario y salimos de mysql.
	
	mysql -u root -p radius;

	mysql> describe radcheck;
	``
	+-----------+------------------+------+-----+---------+----------------+
	| Field     | Type             | Null | Key | Default | Extra          |
	+-----------+------------------+------+-----+---------+----------------+
	| id        | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
	| username  | varchar(64)      | NO   | MUL |         |                |
	| attribute | varchar(64)      | NO   |     |         |                |
	| op        | char(2)          | NO   |     | ==      |                |
	| value     | varchar(253)     | NO   |     |         |                |
	+-----------+------------------+------+-----+---------+----------------+
	5 rows in set (0.00 sec)	
	``
	
	mysql> INSERT INTO radcheck (username,attribute,op,value) \
			VALUES('usuario1','password','==','usuario1');

	mysql> quit

Reiniciamos el servidor radius

	service freeradius restart
	``
	[ ok ] Stopping FreeRADIUS daemon: freeradius.
	[ ok ] Starting FreeRADIUS daemon: freeradius.
	``
	
Testeando la autenticación

	Ahora tenemos que probar que el usuario que hemos añadido a la base 
	de datos de radius se puede autenticar en radius, el proceso es el mismo
	que para el usuario de prueba que anteriormente hicimos, reciviendo un
	( ACCESS-ACCEPT )
	
	radtest usuario1 usuario1 127.0.0.1 1812 testing123
	``
		Sending Access-Request of id 143 to 127.0.0.1 port 1812
		User-Name = "usuario1"
		User-Password = "usuario1"
		NAS-IP-Address = 172.17.0.4
		NAS-Port = 1812
		Message-Authenticator = 0x00000000000000000000000000000000
		rad_recv: Access-Accept packet from host 127.0.0.1 port 1812, id=143, length=20
	``

Ahora tenemos Freeradius con Mysql autenticando en local, 
ahora nos interesa que freeradius autentique clientes remotos






INSERT INTO nas (nasname, shortname, type, secret) VALUES ('172.17.0.5', 'servidor', 'other', 'radius');










#### MYSQL SERVER INSTALL AND CONFIG THE FIRST ACCESS

apt-get install mysql-server

service mysql start

mysql_secure_installation

``
		NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MySQL
			  SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!


		In order to log into MySQL to secure it, we'll need the current
		password for the root user.  If you've just installed MySQL, and
		you haven't set the root password yet, the password will be blank,
		so you should just press enter here.

		Enter current password for root (enter for none): 
		OK, successfully used password, moving on...

		Setting the root password ensures that nobody can log into the MySQL
		root user without the proper authorisation.

		Set root password? [Y/n] y
		New password: 
		Re-enter new password: 
		Password updated successfully!
		Reloading privilege tables..
		 ... Success!


		By default, a MySQL installation has an anonymous user, allowing anyone
		to log into MySQL without having to have a user account created for
		them.  This is intended only for testing, and to make the installation
		go a bit smoother.  You should remove them before moving into a
		production environment.

		Remove anonymous users? [Y/n] y
		 ... Success!

		Normally, root should only be allowed to connect from 'localhost'.  This
		ensures that someone cannot guess at the root password from the network.

		Disallow root login remotely? [Y/n] y
		 ... Success!

		By default, MySQL comes with a database named 'test' that anyone can
		access.  This is also intended only for testing, and should be removed
		before moving into a production environment.

		Remove test database and access to it? [Y/n] y
		 - Dropping test database...
		ERROR 1008 (HY000) at line 1: Can't drop database 'test'; database doesn't exist
		 ... Failed!  Not critical, keep moving...
		 - Removing privileges on test database...
		 ... Success!

		Reloading the privilege tables will ensure that all changes made so far
		will take effect immediately.

		Reload privilege tables now? [Y/n] y
		 ... Success!

		Cleaning up...



		All done!  If you've completed all of the above steps, your MySQL
		installation should now be secure.

		Thanks for using MySQL!
``


#### KERBEROS SERVER INSTALL AND CONFIG

apt-get install krb5-admin-server

1. Editart /etc/krb5.conf, para definir el reino de kerberos
		





#### WEB

*esta sección esta destinada al servidor web y frontends*

apt-get install apache2 php ETC


##### Daloradius

1. Descargar paquete de la pagina oficial
1. Descomprimirlo en /usr/share/src/
1. Cambiar nombre de directorio
1. Si hace falta cambiar permisos a propietario del servicio web
1. Crear VIRTUAL HOST para DALORADIUS
	``Alias /myradius "/usr/share/src/daloradius/"
	<Directory /var/www/daloradius-0.9-7/>
	Options None
	order deny,allow
	deny from all
	allow from 127.0.0.1
	allow from <my management system's ip which has a web-browser>
	</Directory> ``
1. Reiniciar el servidor web
1. Acceder a daloradius
	``http://<localhost or the managemet system's ip>/myradius.``
	* administrator
	* radius






RADIUS, RADIUS + MYSQL, RADIUS + LDAP, RADIUS "DALORADIUS"

[RADIUS INSTALL](https://echaleunvistazo.wordpress.com/2012/08/13/servidor-radius-con-debian-freeradius-y-mysql/)
[RDIUS MYSQL DALORADIUS](http://blog.e2h.net/2011/07/01/servidor-radius-con-gestion-web-freeradius-daloradius/)
[RDIUS MYSQL DALORADIUS 2 ](https://www.howtoforge.com/authentication-authorization-and-accounting-with-freeradius-and-mysql-backend-and-webbased-management-with-daloradius)
[RADIUS ISSUES](https://sites.google.com/site/techbobbins/home/articles/freeradius-and-crls)
[8021X](http://tldp.org/HOWTO/html_single/8021X-HOWTO/#what80211i)
[RADIUS LDAP](http://virtcommunity.blogspot.com.es/2012/10/habilitar-autenticacion-ldap-en.html)
[NAS RADIUS](https://wiki.freeradius.org/glossary/NAS)

LDAP

KERBEROS
[KERBEROS INSTALL](https://albertomolina.wordpress.com/2009/06/11/mit-kerberos5-en-gnulinux-debian-lenny/)

HTTP
[Apache Multiprocesamiento](http://www.vozidea.com/diferencias-entre-apache-prefork-event-worker)
[LAMP Server](https://www.linode.com/docs/web-servers/lamp/lamp-on-debian-8-jessie)

MYSQL


DOCKER
[DOCKER COMPOSE DOCKERFILE](https://github.com/brunocascio/docker-espanol)
[DOCKER COMPOSE NETWORK](https://github.com/brunocascio/docker-espanol)
[DOCKER FILE BEST PRACT](http://crosbymichael.com/dockerfile-best-practices-take-2.html)
[DOCKER WRITE](https://rominirani.com/docker-tutorial-series-writing-a-dockerfile-ce5746617cd)


[DOCKER COMPOSE VIDEO](https://www.youtube.com/watch?v=gtoT0By8yh4)






PROBLEMAS


ERROR 1
> dd if=/dev/urandom of=./random count=10

ERROR 2 rlm_eap: SSL error error:0200100D
> chmod 444 /etc/freeradius/certs/dh
