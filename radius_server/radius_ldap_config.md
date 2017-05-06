# Autenticacación contra un servidor LDAP

## Como habilitar la autenticación contra el servidor LDAP

NOTA: __ Instalar los paquetes necesarios__ **freeradius-ldap**.

### 0. Preparando LDAP para autenticar:
	1. Descargar schema radius para LDAP
		wget http://open.rhx.it/phamm/schema/radius.schema
	2. Copiar en el directorio de schemas de ldap
		cp radius.schema /etc/openldap/schema/
	3. Añadirlo a la configuracion:
		NOTA: __ Si el servidor ldap ya esta en marcha, tendremos que re-configurar el siguiente fichero.
		Para que los cambias con el nuevo esquema se apliquen, podemos añadir el codigo al fichero de configuración antes de 
		cargar nuestro servidor ldap con el arbol de nuestra organización__
		Fichero: **slapd-cn\=config-zion.com.conf**
		
		include /etc/openldap/schema/radius.schema

### 1. En el servidor Radius editaremos:
	Fichero: **/etc/freeradius/modules/ldap**

	``
	ldap {
       #
       #  Note that this needs to match the name in the LDAP
       #  server certificate, if you're using ldaps.
	server = "openldap.example.com"
	basedn = "dc=example,dc=com"
	identity = "cn=Manager,ou=people,dc=example,dc=com"
	filter = "(uid=%{Stripped-User-Name:-%{User-Name}})"
	base_filter = "(objectclass=radiusprofile)"
	start_tls = no
	groupmembership_filter = "(|(&(objectClass=GroupOfNames)(member=%{Ldap-UserDn}))(&(objectClass=GroupOfUniqueNames)(uniquemember=%{Ldap-UserDn})))"
	profile_attribute = "radiusprofile"
	access_attr = "uid"
	dictionary_mapping = {raddbdir}/ldap.attrmap
	ldap_connections_number = 10
	timeout = 4
	timelimit = 5
	net_timeout = 1
	set_auth_type = yes
}	
	#EL fichero sigue
	.....
	``
#### Donde:
	1. server: Nombre del servidor Ldap / IP
	2. identity: Usuario con privilegios en ldap y dominio de busqueda
	3. password: Password del usuario administrador
	4. basedn: Donde buscar en LDAP

	NOTA:__ Los otros campos no los tocamos por el momento a no ser que sea preciso__

### 2. Editaremos tambien el siguiente fichero:

	NOTA: __Descomentaremos__ **authorize** __y__ **authenticate**

	Fichero: **/etc/freeradius/sites-enabled/default**
	
	``
	authorize {
            #
            #  The ldap module will set Auth-Type to LDAP if it has not
            #  already been set
             ldap 
             ....
 authenticate {
            # Uncomment it if you want to use ldap for authentication
            #
            # Note that this means "check plain-text password against
            # the ldap database", which means that EAP won't work,
            # as it does not supply a plain-text password.
             Auth-Type LDAP {
             ldap
             }
	``





### 3. Reiniciamos el servicio freeradius:
	service freeradius stop

### 4. Comprobamos mediante radtest que todo funciona correctamente:
	radtest usuarioldap usuarioldap 172.18.0.3 1812 radius



[LDAP RADIUS](https://tecadmin.net/freeradius-authentication-with-openldap/#)
