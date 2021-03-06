ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}
LABEL maintainer="<darodrig>"
# Useful info: https://www.inmotionhosting.com/support/edu/wordpress/install-wordpress-debian-10/
ARG DB_NAME
ARG MSQL_ADMIN
ARG MSQL_PW
ARG DB_HOST

RUN apt-get update &&\
    apt-get install -yq \
        wget \
        curl \
        tar \
        netcat \
    mariadb-client php-cli php-mysql php-gd php-xml php7.3-fpm
# RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
# RUN echo "deb https://packages.sury.org/php/ ${DEBIAN_VERSION} main" | tee /etc/apt/sources.list.d/php.list

#Config php-fpm

# add user test with password 1234
# RUN useradd -m -p 1234 test

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
COPY ./conf/entrypoint.sh /var/www/html/entrypoint.sh
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /var/www/.wp-cli/cache/ && \
    chown -R www-data:www-data /var/www/.wp-cli/cache/
RUN chown -R www-data:www-data /var/log/
RUN mkdir /run/php && chown -R www-data:www-data /run/php
RUN sed '/^listen =/s/\/run\/php\/php7.3-fpm.sock/9000/' -i /etc/php/7.3/fpm/pool.d/www.conf && cat /etc/php/7.3/fpm/pool.d/www.conf &&\
    chown www-data:www-data /etc/php/7.3/fpm/pool.d/www.conf && \
    php-fpm7.3 -t
RUN touch /var/log/php7.3-fpm.log && chown -R www-data:www-data /var/www/html /run/php /var/log/php7.3-fpm.log
USER www-data
WORKDIR /var/www/html

# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz && \
#     mv wordpress/* . && \
#     rm -rf wordpress latest.tar.gz && \
#     cp wp-config-sample.php wp-config.php && \
#     chown -R www-data:www-data .

# RUN sed -i "s/database_name_here/${DB_NAME}/g" wp-config.php && \
#     sed -i "s/username_here/${MSQL_ADMIN}/g" wp-config.php && \
#     sed -i "s/password_here/${MSQL_PW}/g" wp-config.php && \
#     sed -i "s/localhost/${DB_HOST}/g" wp-config.php && \
#     sed -i '21s/^/define("FORCE_SSL_ADMIN", true);\n/' wp-config.php

RUN wp core download --path="/var/www/html/" --locale="es_ES"

# RUN wp core config --path="/var/www/html/" --dbuser=${MSQL_ADMIN}  \
#     --dbpass="${MSQL_PW}" --dbhost="${DB_HOST}" --dbname="${DB_NAME}" \
#     --dbprefix="wp_" --skip-check
ARG WP_CLI_CACHE_DIR=/var/www/html/.wp-cli/cache


ENV WP_URL=${WP_URL}
ENV WP_TITLE=${WP_TITLE}
ENV WP_ADMIN=${MSQL_ADMIN}
ENV WP_PASS=${MSQL_PW}
ENV WP_MAIL=${WP_MAIL}
ENV WP_CLI_CACHE_DIR=/var/www/html/.wp-cli/cache

COPY --chown=www-data:www-data conf/entrypoint.sh /entrypoint.sh
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "--fail", "--silent", "--show-error", "--retry", "3", "--retry-delay", "5", "--insecure", "-I", "https://nginx/" ]
ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
