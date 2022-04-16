FROM debian:buster
ARG SQL_ADMIN=test
ARG SQL_ADMIN_PW=test
RUN apt-get update && apt-get install -y mariadb-server


RUN service mysql start &&\
	mysql -e "CREATE USER '$SQL_ADMIN'@'localhost' identified by '$SQL_ADMIN_PW';" 

# change root password
RUN service mysql start &&\
	mysql -e "CREATE DATABASE IF NOT EXISTS wpdb;" &&\
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${SQL_ADMIN}'@'%' IDENTIFIED BY '${SQL_ADMIN_PW}';" &&\
	mysql -e "FLUSH PRIVILEGES;"
RUN service mysql start  &&\
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ADMIN_PW';"

HEALTHCHECK --start-period=5m \
  CMD mysql -e 'SELECT @@datadir;' || exit 1

CMD ["mysqld"]