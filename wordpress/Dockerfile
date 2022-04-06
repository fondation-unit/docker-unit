FROM php:8.1-fpm

ENV PHP_INI_DIR /usr/local/etc/php
COPY ./php.ini "$PHP_INI_DIR/php.ini"
RUN CFLAGS="$CFLAGS -D_GNU_SOURCE" docker-php-ext-install sockets

RUN apt-get -y update && apt-get install -y \
    g++ \
    libzip-dev \
    libxml2-dev \
    libicu-dev \
    libpng-dev \
    zlib1g-dev

RUN docker-php-ext-install mysqli 
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
RUN docker-php-ext-install opcache
RUN docker-php-ext-install gd

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN docker-php-ext-install soap

WORKDIR /var/www/html/

COPY ./src /var/www/html
COPY ./unt-config.php /var/www/html
RUN chown -R www-data:www-data /var/www/html/*
