# De que trata el proyecto?
**Una explicación de lo que se trata el proyecto y las tecnicas que se emplean**

El proyecto principalmente trata sobre radius y su implementación con diferentes
servicios y aplicaciones.

Las técnicas empleadas para la implementación de los servicios y aplicaciones.

Los temas que serán tratados son los siguientes:

Radius: Autenticación, Autorización, Acceso (AAA), implementación de un servidor
con Autenticación LDAP y Autorización de KERBEROS, configuración de un 
punto de acceso Wifi con WPA-EAP ( WPA- EXTENSIBLE APPLICATION PROTOCOL ),
segurización del servició mediante TLS/SSL con certificados propios creados
con una Autoridad Certificadora.

Mysql: Basicamente este contendra las bases de datos que requieran en el proyecto,

	NOTA: no lo usaremos para radius aunque si veremos un annexo de como configurar
	freeradius con soporte de base de datos ( _en el caso que de tiempo y como complementario del proyecto ).

	Freeradius
	
	Daloradius
	
Ldap: Servicio que contendra el arbol de directorio que utilizara ldap para
authenticar los usuarios y los puntos de acceso ( en el caso que sea posible ).
Esta sera una de las implementaciónes "Serias que haremos con Freeradius, 
otra de ella sera implementar Kerberos ).

Kerberos: Servicio que contendra el Reino de nuestro "proyecto Freeradius Ldap kerberos TLS/SSL "
		" FALTA INFORMACIÓN "
		
Autoridad Certificadora: Sera un host encargado de crear certificaciones, 
para los servicios que queramos segurizar con TLS/SSL, con el crearemos todo lo posible
para que nuestro "proyecto" se lo más seguro posible
