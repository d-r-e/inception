FROM debian:buster
ARG MSQL_ADMIN=test
ARG MSQL_PW=test
RUN apt-get update && apt-get install -y mariadb-server

# RUN apt-get install -y ufw
# RUN ufw allow 3306 && ufw reload

RUN service mysql start &&\
	mysql -e "CREATE USER '$MSQL_ADMIN'@'localhost' identified by '$MSQL_PW';" 

# Create db
RUN service mysql start &&\
	mysql -e "CREATE DATABASE IF NOT EXISTS wpdb;" &&\
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MSQL_ADMIN}'@'%' IDENTIFIED BY '${MSQL_PW}';" &&\
	mysql -e "FLUSH PRIVILEGES;"
# change root password
RUN service mysql start  &&\
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MSQL_PW';"

HEALTHCHECK --start-period=5m \
  CMD mysql -e 'SELECT @@datadir;' || exit 1

CMD ["mysqld"]