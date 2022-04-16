ARG DEBIAN_VER=buster
FROM debian:${DEBIAN_VER}

ARG MSQL_ADMIN
ARG MSQL_PW
ARG DB_NAME


RUN apt-get update && apt-get install -y mariadb-server

# RUN apt-get install -y ufw
# RUN ufw allow 3306 && ufw reload

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

HEALTHCHECK --start-period=5m \
  CMD mysql -e 'SELECT @@datadir;' || exit 1

CMD ["mysqld"]