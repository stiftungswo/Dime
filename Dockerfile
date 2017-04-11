FROM php:7.1.3-fpm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -qqy nginx supervisor git locales libssl-dev libmcrypt-dev libicu-dev openvpn curl links cron redis-tools mysql-client vim && \
    echo "cs_CZ.UTF-8 UTF-8" > /etc/locale.gen && locale-gen cs_CZ.UTF-8 && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    pecl install mongodb && docker-php-ext-enable mongodb && \
    pecl install redis && docker-php-ext-enable redis && \
    pecl install apcu && docker-php-ext-enable apcu && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    docker-php-ext-install bcmath mbstring intl iconv mcrypt zip mysqli pdo pdo_mysql opcache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/* && \
    touch /run/nginx.pid && touch /run/php-fpm.pid && touch /run/supervisord.pid && touch /var/run/crond.pid && \
    chown -R www-data:www-data /var/www /var/lib/nginx /run/nginx.pid /run/php-fpm.pid /run/supervisord.pid /var/run/crond.pid && \
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get install dart && \
    ulimit -n 16384

COPY .docker/rootfs /

RUN chown www-data:www-data /etc/supervisor/supervisord.conf && \
    chmod +x /entrypoint.sh && \
    mkdir -p /var/www/.composer && \
    chmod -R 777 /var/www/.composer && \
    chown -R www-data:www-data /var/www/*

WORKDIR /var/www/html

EXPOSE 8080

CMD ["/entrypoint.sh"]
