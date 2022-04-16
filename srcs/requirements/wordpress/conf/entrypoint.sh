#!/bin/bash
sleep 10
wp core install\
    --url=${WP_URL}\
    --title=${WP_TITLE}\
    --admin_name=${WP_ADMIN}\
    --admin_password=${WP_PASS}\
    --admin_email=${WP_MAIL} && \
    wp user create ${WP_ADMIN} ${WP_PASS} --role=administrator
/usr/sbin/php-fpm7.3 --nodaemonize