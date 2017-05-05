___Servidor LDAP " Lightweight Directory Access Protocol "___

__Instalación y configuracion de un servidor LDAP en Raspberry utilizando
Raspbian__

# LDAP

## LDAP: Instalar y configurar.

### 1. Instalar LDAP:

	1. sudo apt-get install
	
### 2. Configurar el backend de LDAP.

	``
version: 1
changeType: add
dn: olcDatabase=hdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcHdbConfig
olcDatabase: {2}hdb
olcDbDirectory: /var/lib/ldap
olcSuffix: dc=zion,dc=com
olcAccess: {0}to attrs=userPassword,shadowLastChange by self write by anonymous auth by dn="cn=admin,dc=zion,dc=com" write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by self write by dn="cn=admin,dc=zion,dc=com" write by * read
olcLastMod: TRUE
olcRootDN: cn=admin,dc=zion,dc=com
olcRootPW: ZAaAJ1989-2017
olcDbCheckpoint: 512 30
olcDbConfig: {0}set_cachesize 0 2097152 0
olcDbConfig: {1}set_lk_max_objects 1500
olcDbConfig: {2}set_lk_max_locks 1500
olcDbConfig: {3}set_lk_max_lockers 1500
olcDbIndex: objectClass eq

	``

### 3. Agregar Organizacion LDAP:

	``
dn: dc=zion,dc=com
dc: openstack
objectClass: dcObject
objectClass: organizationalUnit
ou: openstack

dn: ou=UserGroups,dc=zion,dc=com
objectClass: organizationalUnit
ou: UserGroups

dn: ou=Users,dc=zion,dc=com
objectClass: organizationalUnit
ou: Users

dn: ou=Roles,dc=zion,dc=com
objectClass: organizationalUnit
ou: Roles

dn: ou=Projects,dc=zion,dc=com
objectClass: organizationalUnit
ou: Projects

dn: cn=9fe2ff9ee4384b1894a90878d3e92bab,ou=Roles,dc=zion,dc=com
objectClass: organizationalRole
ou: _member_
cn: 9fe2ff9ee4384b1894a90878d3e92bab
	``

### 4. Agregar Usuarios:

	``
dn: cn=altair fernandez,ou=Users,dc=zion,dc=com
objectclass: inetOrgPerson
cn: altair fernandez
cn: altair fernandez
cn: MrRastayoung
sn: fernandez
uid: afernandez
userpassword: afernandez_first
carlicense: B 123
homephone: 420-420-4201
mail: altair.trabajo@gmail.com
mail: webmaster@zion.com
description: Aqui y Ahora
ou: Human Resources

dn: cn=Larry Cai,ou=Users,dc=zion,dc=com
objectclass: inetOrgPerson
cn: Larry Cai
sn: Cai
uid: larrycai
userpassword: LarryCai
carlicense: HISCAR 123
homephone: 555-111-2222
mail: larry.caiyu@gmail.com
description: hacker guy
ou: Development Department
	``






[LDAP TLS](http://mageconfig.blogspot.com.es/2014/11/enable-ssl-in-openldap.html)
