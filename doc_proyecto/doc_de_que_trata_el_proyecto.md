# Radius
``Aqui y Ahora``
## De que trata el proyecto?
**Una explicación de lo que se trata el proyecto y las tecnicas que se emplean**


Los temas que serán tratados son los siguientes:

*Radius*: Autenticación, Autorización, Acceso (AAA):
1. Que es radius? [Servidor Radius](http://trabajotele08.blogspot.com.es/)
2. Implementación de radius?
  1. Protocolos de Autenticación? [Metodos Autenticación](http://karenmarce.blogspot.es/1307915040/) 
    1. PAP
    2. CHAP
    3. EAP
    4. MSCHAP
    5. ACCESO SIN AUTENTICAR
3. Metodos de Autenticación?
0.3.1. FILE
0.3.2. UNIX
0.3.3. PAM
0.3.4. SQL
0.3.5. LDAP
1. Implementación de un servidor Mysql para almazenar la base de datos de:
  	1. Clientes para autenticación y autorización mediante mysql.
	2. Clientes NAS "Network Access Server".
	3. Conexiones Aceptadas, Conexiones Rechazadas.
	3. Base de datos para los frontends necesarios.
  2. Implementación de un servidor Radius con Autenticación LDAP:
  	1. Organización que contendra: Grupos, Usuarios, Hosts
	2. Clientes para autenticación y autorización mediante LDAP
  3. Configuración de un punto de acceso Wifi con WPA2-AES:
  	1. AP Wifi por el que se conectaran y se autenticaran mediante LDAP.
  4. Configuración de una Autoridad Certificadora:
	1. Conexiones mediante TLS/SSL
	2. Certificados, Peticiones, Peticiones firmadas, Claves de servidor

>**Freeradius**
  1. Ques es?
  2. Que nos proporciona?
  3. Que uso le daremos?
  	1. [EDUROAM](http://www.grc.upv.es/docencia/tra/PDF/Radius.pdf)
	2. [SEGURIDAD WIFI RADIUS](https://www.securityartwork.es/2013/11/06/seguridad-wi-fi-empresarial-servidores-radius-i/)
>**MySQL**
  1. Ques es?
  2. Que nos proporciona?
  3. Que uso le daremos?

> **Ldap**: 
  1. Que es?
  2. Que nos proporciona?
  3. Que uso le daremos?
  Servicio que contendra el arbol de directorio que utilizara ldap para authenticar los usuarios y los puntos de acceso ( en el caso que sea posible ).
		
> **Autoridad Certificadora**: 
  1. Que es?
  2. Que nos proporciona?
  3. Que uso le daremos?
  Sera un host encargado de crear certificaciones, para los servicios que queramos segurizar con TLS/SSL, con el crearemos todo lo posible para que nuestro "proyecto" sea lo más seguro posible.
