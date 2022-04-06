FROM php:8.1-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libmcrypt-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm

#RUN pecl install mcrypt-1.0.4
RUN npm cache clean -f
RUN npm install -g n
RUN n stable

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# PHP extensions
RUN docker-php-ext-install mysqli mbstring exif pcntl bcmath gd zip opcache intl
#RUN docker-php-ext-enable mcrypt

# Latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

WORKDIR /var/www/html

COPY ./src /var/www/html
COPY ./unt-config.php /var/www/html
RUN chown -R www-data:www-data /var/www/html/*

WORKDIR /var/www/html/wp-content/themes/unt
RUN npm install --save --legacy-peer-deps

USER $user