ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

ARG MSQL_ADMIN
ARG MSQL_PW
ARG DB_NAME


RUN apt-get update && apt-get install -y mariadb-server

# RUN apt-get install -y ufw
# RUN ufw allow 3306 && ufw reload

COPY ./conf/mdb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

RUN mysql_install_db --user=mysql --datadir="/var/lib/mysql" &&\
	/usr/bin/mysqld_safe --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.conf &

RUN service mysql start &&\
	mysql -e "CREATE USER '$MSQL_ADMIN'@'localhost' identified by '$MSQL_PW';" 

# Create db
RUN service mysql start &&\
	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" &&\
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MSQL_ADMIN}'@'%' IDENTIFIED BY '${MSQL_PW}';" &&\
	mysql -e "FLUSH PRIVILEGES;"
# change root password
RUN service mysql start  &&\
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MSQL_PW';FLUSH PRIVILEGES;"

# /usr/bin/mysqld_safe --user=$MSQL_ADMIN --password=$MSQL_PW 
CMD ["/usr/bin/mysqld_safe", "--user=$MSQL_ADMIN", "--password=$MSQL_PW"]