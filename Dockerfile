FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    curl \
    nodejs \
    npm \
    libpq-dev \
    unzip && \   
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_pgsql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY ./src /var/www/html

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

RUN composer install --no-dev --optimize-autoloader

RUN npm install && npm run build

RUN composer global require laravel/installer

ENV PATH="$PATH:/root/.composer/vendor/bin"

RUN chmod +x artisan

EXPOSE 9000

CMD ["php-fpm"]
