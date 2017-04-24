# Proyecto final 


## Servidor Radius + Ldap + Kerberos + Http + TLS
![FreeRadius](/img/freeradius.png)
![OpenLdap](/img/openldap.png)
![Kerberos](/img/kerberos_mit.png)
![Daloradius](/img/daloradius.jpg)
![Mysql](/img/mysql.jpg)
![Tls/ssl](/img/tls_ssl.png)
![Python](/img/python.png)
![Raspbian](/img/raspbian.png)
![Hypriot](/img/hypriot_0.png)
![Docker](/img/docker.png)



### En que consiste este proyecto
  Este proyecto consiste en montar un servicio de autenticación wifi basado
  en freeradius con autenticación via ldap + kerberos + tls/ssl

  Este proyecto esta elaborado con docker compose, esto se deve a que es un
  un proyecto multiservició, y queremos exprimir al máximo docker, por eso 
  elijo realizar el proyecto con docker compose compuesto por los diferentes docker
  de servicios que implemento en el proyecto Radius 

### Como esta ordenado
  De momento no tiene un orden concreto podemos encontrar un borrador de lo que podra ser la estructura del proyecto en 
  [Borrador index estructura proyecto](doc_proyecto/index.md)


### Servicios y peculiaridades
[FREERADIUS](/radius_server/)
[LDAP](/ldap_server/)
[KERBEROS](/kerberos_server/)
[HTTP](/http_server/)
[MYSQL](/mysql_server/)
[TLS/SSL](/ca_host/)

``Autor: Altair Fernandez Castro
  Curso: ASIX 2016-2017
``
