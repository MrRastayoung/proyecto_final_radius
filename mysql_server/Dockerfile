# Nos basamos en una imagen para procesadores ARM, esta concretamente para raspberry 
FROM resin/rpi-raspbian

# Persona encargada de esta imagen
MAINTAINER Altair Fernandez Castro Version 0.1

#####    IMAGEN    #####
#RUN echo "mysql-server-5.5 mysql-server/root_password password myjupiter" | debconf-set-selections && \
#  echo "mysql-server-5.5 mysql-server/root_password_again password myjupiter" | debconf-set-selections && \
#  echo "mysql-server-5.5 mysql-server-5.5/postrm_remove_databases boolean true" | debconf-set-selections  

ENV MYSQL_USER=mysql \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mysql-server \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/docker
COPY conf_files/entrypoint.sh /sbin/entrypoint.sh
COPY conf_files/insert_bd.sh /opt/docker/
RUN chmod 755 /sbin/entrypoint.sh; chmod 755 /opt/docker/insert_bd.sh 

RUN /bin/bash -c "/sbin/entrypoint.sh &" && \
  ps -ax && \ 
  sleep 20s && \
 /bin/echo "Insertando bases de datos" && \
  mysql -e "create user 'radius'@'localhost';" && \
  mysql -e "create database radius;" 

EXPOSE 3306/tcp
VOLUME ["${MYSQL_DATA_DIR}", "${MYSQL_RUN_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/mysqld_safe"]
