FREERADIUS TLS EAP

1. Crear certificado de la CA
	NOTA: __Generar la propia CA que ella misma firma__
	openssl genrsa -out ca.key 2048
	openssl genrsa -out ca.key 2048 -des3
	openssl req -x509 -new -nodes -key ca.key -days 4024 -out ca.pem
	
	``
	Country Name (2 letter code) [XX]:Es
	tate or Province Name (full name) []:BARCELONA
	ocality Name (eg, city) [Default City]:MATARO
	rganization Name (eg, company) [Default Company Ltd]:ZionSociety
	rganizational Unit Name (eg, section) []: Tecnologia sin cables 
	ommon Name (eg, your name or your server's hostname) []:zion.com
	mail Address []:altair.trabajo@gmail.com

	``


2. Crear CSR
	openssl genrsa -des3 -out server.key 2048
	openssl req -new -key server.key -out server.csr

3. Firmar CSR
	openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key  -CAcreateserial -out server.crt -days 500
	
	``
	ountry Name (2 letter code) [XX]:Es
	tate or Province Name (full name) []:Barcelona
	ocality Name (eg, city) [Default City]:Mataro
	rganization Name (eg, company) [Default Company Ltd]:ZionRadius
	rganizational Unit Name (eg, section) []:zion wifi sin limite
	ommon Name (eg, your name or your server's hostname) []:zion.com
	mail Address []:altair.trabajo@gmai.com

	lease enter the following 'extra' attributes
	o be sent with your certificate request
	 challenge password []:Zion
	n optional company name []:passwd
	`

4. Modificar radius:
	Fichero: **/etc/freeradius/eap.conf**

	``
	 tls {
	.
	.
	certdir = ${confdir}/certs
	cadir = ${confdir}/certs
	private_key_password = saman #This was generated when server keys are generated.
	private_key_file = ${certdir}/server.key
	certificate_file = ${certdir}/server.crt
	CA_file = ${cadir}/ca.pem
	dh_file = ${certdir}/dh
	random_file = /dev/urandom 
	.
	.
	. 
	} 
	``

5. Seguimos con Radius:
	Fichero: **/etc/freeradius/modules/inner-eap**
	
	1. Generar certificado y firma utilizando el certificado de la CA, estos certificados se utilizaran en inner EAP.
		# CREAR CSR
			openssl genrsa -des3 -out server-inner.pem 2048
			openssl req -new -key server-inner.pem -out server-inner.csr

		# Firmar CSR
			openssl x509 -req -in server-inner.csr -CA ca.pem -CAkey ca.key  -CAcreateserial -out server-inner.crt -days 500

	``
	tls {
	.
	.
	certdir = ${confdir}/certs
	cadir = ${confdir}/certs
	private_key_password = saman #This was generated when server keys are generated.
	private_key_file = ${certdir}/server-inner.key
	certificate_file = ${certdir}/server-inner.crt
	CA_file = ${cadir}/ca.pem
	dh_file = ${certdir}/dh
	random_file = /dev/urandom 
	.
	.
	. 
	} 
	``


[SELF SIGNED SSL CERTIFICATE](http://www.akadia.com/services/ssh_test_certificate.html)
[RADIUS + LDAP + TLS ](http://mageconfig.blogspot.com.es/2014/11/configure-radius-with-ldap-for-network.html)
