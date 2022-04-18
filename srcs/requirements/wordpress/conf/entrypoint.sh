#!/bin/bash

set -ex
until nc -z mariadb 3306; do
	echo  "Waiting for database connection..."
  sleep 1
done
wp core install --path="/var/www/html/" --url="darodrig.42.fr" \
    --title=${WP_TITLE} --admin_user="${WP_ADMIN}" --admin_password="${WP_PASS}" \
    --admin_email="$WP_MAIL" --skip-email
/usr/sbin/php-fpm7.3 --nodaemonize 

# tail -f