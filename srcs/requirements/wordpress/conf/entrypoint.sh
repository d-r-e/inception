#!/bin/bash

export WP_CLI_CACHE_DIR=/var/www/html/.wp-cli/cache
set -ex
sleep 3
ls -I entrypoint.sh | xargs rm -rf &> /dev/null
wp core download --path="/var/www/html" --locale="es_ES"
wp core config --force --path="/var/www/html" \
    --dbname="${DB_NAME}" --dbuser="${MSQL_ADMIN}"
    --dbpass="${WP_PASS}" --dbhost="mariadb" \
    --dbprefix="wp_" --skip-check 
wp core install\
    --url=mariadb\
    --title=${WP_TITLE}\
    --admin_name=${WP_ADMIN}\
    --admin_password=${WP_PASS}\
    --admin_email=${WP_MAIL}
wp user create ${WP_ADMIN} ${WP_PASS} --role=administrator
/usr/sbin/php-fpm7.3 --nodaemonize