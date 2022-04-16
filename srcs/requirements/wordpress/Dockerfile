FROM debian:buster
LABEL maintainer="<darodrig>"
# Useful info: https://www.inmotionhosting.com/support/edu/wordpress/install-wordpress-debian-10/
ARG DB_NAME
ARG MSQL_ADMIN
ARG MSQL_PW
ARG DB_HOST

RUN apt-get update &&\
    apt-get install -y \
        wget \
        tar \
        php \
        libapache2-mod-php php-mysql

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz && \
    cp wp-config-sample.php wp-config.php && \
    chown -R www-data:www-data .
RUN sed -i "s/database_name_here/${DB_NAME}/g" wp-config.php && \
    sed -i "s/username_here/${MSQL_ADMIN}/g" wp-config.php && \
    sed -i "s/password_here/${MSQL_PW}/g" wp-config.php && \
    sed -i "s/localhost/${DB_HOST}/g" wp-config.php

USER www-data

