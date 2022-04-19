#!/bin/bash

set -e

until nc -z mariadb 3306; do
	echo  "\rWaiting for database connection..."
  sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Creating wordpress database"

  wp config create --path="/var/www/html/" --dbname="${DB_NAME}" \
  --dbuser="${MSQL_ADMIN}" --dbpass="${MSQL_PW}" --dbhost="${DB_HOST}" --dbprefix="wp_" --locale="es_ES"

  wp core install --path="/var/www/html/" --url="${WP_URL}" \
      --title=${WP_TITLE} --admin_user="${WP_ADMIN}" --admin_password="${WP_PASS}" \
      --admin_email="$WP_MAIL" --skip-email

  echo "WordPress configured"
fi

/usr/sbin/php-fpm7.3 --nodaemonize 

# tail -f