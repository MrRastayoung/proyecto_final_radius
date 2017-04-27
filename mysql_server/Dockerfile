FROM resin/rpi-raspbian
MAINTAINER " Altair version 0.1

RUN apt-get update && apt-get install -y -qq mysql-server; exit 0

RUN mkdir /opt/docker

COPY conf_files /opt/docker

COPY /opt/docker/my.cnf /etc/mysql/


RUN mysql -u root -p \echo  "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'"


WORKDIR /opt/docker

EXPOSE 3306/tcp

ENTRYPOINT /usr/bin/mysqld_safe && /bin/bash
