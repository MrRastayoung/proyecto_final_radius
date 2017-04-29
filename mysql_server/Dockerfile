FROM resin/rpi-raspbian
MAINTAINER " Altair version 0.1


### SOURCE

# https://github.com/sameersbn/docker-mysql



ENV MYSQL_USER=mysql \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mysql-server \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

RUN mkdir /opt/docker
WORKDIR /opt/docker

COPY conf_files/my.cnf /etc/mysql/
COPY conf_files/insert_bd.sh /opt/docker/

RUN chmod +x /opt/docker/insert_bd.sh && sh -c /opt/docker/inser_bd.sh

## RUN SCRIPT BD RADIUS DALORADIUS ETC

EXPOSE 3306/tcp
VOLUME ["${MYSQL_DATA_DIR}", "${MYSQL_RUN_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/mysqld_safe"]
