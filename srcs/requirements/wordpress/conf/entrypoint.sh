#!/bin/bash

set -e

until nc -z mariadb 3306; do
	echo  "Waiting for database connection..."
  sleep 1
done

if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Creating wordpress database"
  # rm -rf $(ls -A /var/www/html/ | grep -v wp-config.php)
  wp config create --path="/var/www/html/" --dbname="${DB_NAME}" \
  --dbuser="${MSQL_ADMIN}" --dbpass="${MSQL_PW}" --dbhost="${DB_HOST}" --dbprefix="wp_" --locale="es_ES"
  sleep 1
  wp core install --path="/var/www/html/" --url="${WP_URL}" \
      --title=${WP_TITLE} --admin_user="${WP_ADMIN}" --admin_password="${WP_PASS}" \
      --admin_email="$WP_MAIL" --skip-email
  ## add regular user to wp
  wp user create marvin marvin@42madrid.com --role=editor --user_pass=${WP_PASS} 

  echo "WordPress configured"
fi

/usr/sbin/php-fpm7.3 --nodaemonize

# tail -f