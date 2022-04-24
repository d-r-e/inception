#!/bin/bash

set -e

until nc -z mariadb 3306; do
	echo  "Waiting for database connection..."
  sleep 1
done

# If not configured
if [ ! -f /var/www/html/wp-config.php || ! -f /var/www/html/.configured ]; then
  echo "Creating wordpress database"
  wp config create --path="/var/www/html/" \
  --dbname="${DB_NAME}" \
  --dbuser="${MSQL_ADMIN}" --dbpass="${MSQL_PW}" \
  --dbhost="${DB_HOST}" --dbprefix="wp_" --locale="es_ES"
  sleep 1
  wp core install --path="/var/www/html/" --url="${WP_URL}" \
      --title=${WP_TITLE} --admin_user="${WP_ADMIN}" --admin_password="${WP_PASS}" \
      --admin_email="$WP_MAIL" --skip-email
  wp user create marvin marvin@42madrid.com --role=editor --user_pass=${WP_PASS}
  echo "WordPress configured"
  touch /var/www/html/.configured
fi

# CMD
/usr/sbin/php-fpm7.3 --nodaemonize
