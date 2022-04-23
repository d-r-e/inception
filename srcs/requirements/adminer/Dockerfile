FROM debian:buster

RUN apt-get update && apt-get install -y \
    wget \
    php7.3 php7.3-cgi php7.3-mysqli php-pear php7.3-mbstring php7.3-gettext php7.3-common php-phpseclib php7.3-mysql \
    mariadb-client php-cli php-mysql php-gd php-xml php7.3-fpm
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html
RUN mkdir /run/php && chown -R www-data:www-data /run/php
RUN mkdir -p /var/www/html/adminer && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/adminer.php
RUN sed '/^listen =/s/\/run\/php\/php7.3-fpm.sock/9001/' -i /etc/php/7.3/fpm/pool.d/www.conf && cat /etc/php/7.3/fpm/pool.d/www.conf &&\
    chown www-data:www-data /etc/php/7.3/fpm/pool.d/www.conf && \
    php-fpm7.3 -t
RUN chown -R www-data:www-data /var/log/
USER www-data
WORKDIR /var/www/html/ 
CMD php -S 0.0.0.0:8080