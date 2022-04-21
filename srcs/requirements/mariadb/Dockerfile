ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

ARG MSQL_ADMIN
ARG MSQL_PW
ARG DB_NAME


RUN apt-get update && apt-get install -yq mariadb-server

# RUN apt-get install -y ufw
# RUN ufw allow 3306 && ufw reload

COPY ./conf/mdb.conf /etc/mysql/mariadb.conf.d/mariadb.cnf

# RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
# RUN mysql_install_db --user=mysql --datadir="/var/lib/mysql" &&\
# 	/usr/bin/mysqld_safe --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.conf &
# RUN	mysql -e "CREATE USER '$MSQL_ADMIN'@'localhost' identified by '$MSQL_PW';" 

# Create db
RUN service mysql start &&\
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};USE ${DB_NAME};" &&\
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MSQL_ADMIN}'@'%' IDENTIFIED BY '${MSQL_PW}';" &&\
	mysql -e "FLUSH PRIVILEGES;"
RUN service mysql start && echo "GRANT ALL PRIVILEGES ON *.* TO '${MSQL_ADMIN}'@'localhost' IDENTIFIED BY '${MSQL_PW}'; \
	FLUSH PRIVILEGES;" | mysql -u root -p""
# change root password
RUN service mysql start  &&\
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MSQL_PW';FLUSH PRIVILEGES;"

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "mysqladmin", "ping" ]
# /usr/bin/mysqld_safe --user=$MSQL_ADMIN --password=$MSQL_PW 
CMD ["mysqld_safe", "--user=mysql", "--datadir=/var/lib/mysql", "--pid-file=/var/run/mysqld/mysqld.pid", "--socket=/var/run/mysqld/mysqld.sock", "--basedir=/usr/local/mysql", "--port=3306", "--bind-address=0.0.0.0"]