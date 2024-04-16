FROM php:8.2-apache-bullseye

RUN apt-get update -y && apt-get install -y libpq-dev libzip-dev

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install zip pdo pdo_pgsql pgsql

COPY . .

RUN composer install
RUN a2enmod rewrite

COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /var/www/html

USER www-data

ENTRYPOINT [ "apache2-foreground" ]