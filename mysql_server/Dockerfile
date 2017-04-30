# Nos basamos en una imagen para procesadores ARM, esta concretamente para raspberry 
FROM resin/rpi-raspbian

# Persona encargada de esta imagen
MAINTAINER Altair Fernandez Castro Version 0.1

#####    IMAGEN    #####
#RUN echo "mysql-server-5.5 mysql-server/root_password password myjupiter" | debconf-set-selections && \
#  echo "mysql-server-5.5 mysql-server/root_password_again password myjupiter" | debconf-set-selections && \
#  echo "mysql-server-5.5 mysql-server-5.5/postrm_remove_databases boolean true" | debconf-set-selections  

ENV MYSQL_DATA_DIR=/var/lib/mysql \ 
  MYSQL_RUN_DIR=/run/mysqld

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mysql-server \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/docker/conf_files

COPY conf_files/*.sql /opt/docker/conf_files/
COPY conf_files/bd_insert.sh /opt/docker/conf_files/

RUN /bin/ls -la /opt/docker/conf_files

COPY conf_files/my.cnf /etc/mysql/
COPY conf_files/startup.sh /opt/docker/

#RUN chmod 755 /sbin/entrypoint.sh

RUN chmod 755 /opt/docker/startup.sh; chmod 755 /opt/docker/conf_files/bd_insert.sh && \
  /bin/bash -c "/opt/docker/startup.sh &" && \
  sleep 25s && \
  /bin/echo "Insertando bases de datos" && \
  ### SCRIPT FREERADIUS
  /bin/bash -c "opt/docker/conf_files/bd_insert.sh" && \
  killall mysqld ;exit 0
  ### SCRIPT DALORADIUS

EXPOSE 3306/tcp
VOLUME ["${MYSQL_DATA_DIR}", "${MYSQL_RUN_DIR}"]

WORKDIR /opt/docker
ENTRYPOINT ["/opt/docker/startup.sh"]
CMD ["/usr/bin/mysqld_safe"]
