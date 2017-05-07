#! /bin/bash
# LDAP
## Script para automatizar el inicio del servicio ldap, cargando la organización y los usuarios LDAP.
########
# regenerar la BD de slapd.d
########

/bin/echo "Regenerando estructura LDAP"
sh /opt/docker/regeBD.sh

#/bin/echo " SSL "
## SSL
#cp /opt/docker/LDAP/server.key /etc/openldap/certs/
#cp /opt/docker/LDAP/server.crt /etc/openldap/certs/
#cp /etc/pki/tls/certs/ca-bundle.crt /etc/openldap/certs/ 
#chown ldap. /etc/openldap/certs/server.key /etc/openldap/certs/server.crt /etc/openldap/certs/ca-bundle.crt



