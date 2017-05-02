#!/bin/bash
set -e
## mediumentrypoint

DB_ROOT_PASS=myjupiter

MYSQL_USER=mysql
MYSQL_DATA_DIR=/var/lib/mysql
MYSQL_RUN_DIR=/run/mysqld
MYSQL_LOG_DIR=/var/log/mysql


create_data_dir() {
  mkdir -p ${MYSQL_DATA_DIR}
  chmod -R 0700 ${MYSQL_DATA_DIR}
  chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_DATA_DIR}
}

create_run_dir() {
  mkdir -p ${MYSQL_RUN_DIR}
  chmod -R 0755 ${MYSQL_RUN_DIR}
  chown -R ${MYSQL_USER}:root ${MYSQL_RUN_DIR}
}

create_log_dir() {
  mkdir -p ${MYSQL_LOG_DIR}
  chmod -R 0755 ${MYSQL_LOG_DIR}
  chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_LOG_DIR}
}

apply_configuration_fixes() {
  # disable error log
  ## añadido en el fichero de configuración
  sed -i -e "s/^log_error/# log_error/" /etc/mysql/my.cnf >/dev/null 2>&1

  # Fixing StartUp Porblems with some DNS Situations and Speeds up the stuff
  # http://www.percona.com/blog/2008/05/31/dns-achilles-heel-mysql-installation/
  cat > /etc/mysql/conf.d/mysql-skip-name-resolv.cnf <<EOF
[mysqld]
skip_name_resolve
EOF
}


initialize_mysql_database() {
  # Si no existe el directorio "/var/lib/mysql/mysql" se inicializa la instalación de la base de datos
  # como usuario que ejecutara el demonio mysqld y la utilizacion de ip's en vez de utilizar los nombres de HOST
  if [ ! -d ${MYSQL_DATA_DIR}/mysql ]; then
    echo "Installing database..."
    mysql_install_db --user=mysql --skip-name-resolve >/dev/null 2>&1

    # Inicializa el demonio de MySQL
    echo "Starting MySQL server..."
    /usr/bin/mysqld_safe >/dev/null 2>&1 &

    # wait for mysql server to start (max 30 seconds)
    timeout=30
    echo -n "Waiting for database server to accept connections"
    while ! /usr/bin/mysqladmin -u root status >/dev/null 2>&1
    do
      timeout=$(($timeout - 1))
      if [ $timeout -eq 0 ]; then
        echo -e "\nCould not connect to database server. Aborting..."
        exit 1
      fi
      echo -n "."
      sleep 1
    done
    echo

    ## create a localhost only, debian-sys-maint user
    ## the debian-sys-maint is used while creating users and database
    ## as well as to shut down or starting up the mysql server via mysqladmin
    echo "Creating debian-sys-maint user..."
    mysql -uroot -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '' WITH GRANT OPTION;"
    
    
    ## USUARIO ADMINISTADOR
    #echo "Creando Usuario administrador..."
    #/usr/bin/mysqladmin -u root password "$DB_ROOT_PASS"

    /usr/bin/mysqladmin --defaults-file=/etc/mysql/debian.cnf shutdown
  fi
}

listen() {
  sed -i -e "s/^bind-address\(.*\)=.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf >/dev/null 2>&1
}

remove_debian_systen_maint_password() {
  #
  # the default password for the debian-sys-maint user is randomly generated
  # during the installation of the mysql-server package.
  #
  # Due to the nature of docker we blank out the password such that the maintenance
  # user can login without a password.
  #
  sed 's/password = .*/password = /g' -i /etc/mysql/debian.cnf >/dev/null 2>&1
}


create_data_dir
create_run_dir
create_log_dir


## insert bd

listen "127.0.0.1"
apply_configuration_fixes
remove_debian_systen_maint_password
initialize_mysql_database
listen "0.0.0.0"

####
exec $(which mysqld_safe)

