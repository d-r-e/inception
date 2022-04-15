FROM debian:buster
RUN apt-get update && apt-get install -y mariadb-server
RUN userdel mysql
RUN useradd -u 42 mysql && mkdir -p /data/mysql && chown -R mysql:mysql /data/mysql
RUN echo $SQL_ADMIN : password $SQL_ADMIN_PW && sleep 10
RUN service mysql start &&\
	mysql -e "CREATE USER '${SQL_ADMIN}'@'localhost' identified by '${SQL_ADMIN_PW}';" &&\
	mysql -e "CREATE DATABASE IF NOT EXISTS wpdb;" &&\
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${SQL_ADMIN}'@'%' IDENTIFIED BY '${SQL_ADMIN_PW}';" &&\
	mysql -e "FLUSH PRIVILEGES;"


LABEL version="1.0"
LABEL description="MariaDB Server"

HEALTHCHECK --start-period=5m \
  CMD mariadb -e 'SELECT @@datadir;' || exit 1
# USER mysql
CMD ["mysqld"]