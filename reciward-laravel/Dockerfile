FROM php:7.3-fpm AS php

WORKDIR /var/www

RUN apt update && apt install unzip

RUN docker-php-ext-install pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www

CMD ["php-fpm"]

