#!/bin/bash

set -ex
# wp core download --path="/var/www/html/" --locale="es_ES"
# wp core config --path="/var/www/html/" --dbuser=mysql  \
#     --dbpass="${MSQL_PW}" --dbhost="${DB_HOST}" --dbname="${DB_NAME}" \
#     --dbprefix="wp_" --skip-check
sleep 5
wp core install --path="/var/www/html/" --url="darodrig.42.fr" \
    --title=${WP_TITLE} --admin_user="${WP_ADMIN}" --admin_password="${WP_PASS}" \
    --admin_email="$WP_MAIL" --skip-email
/usr/sbin/php-fpm7.3 --nodaemonize
# tail -f