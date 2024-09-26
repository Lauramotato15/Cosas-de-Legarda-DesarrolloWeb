# Usa una imagen base de PHP
FROM php:8.3-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd zip pdo pdo_mysql

# Establece el directorio de trabajo
WORKDIR /var/www

# Copia el composer.lock y el composer.json
COPY composer.json composer.lock ./

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala las dependencias de PHP
RUN composer install

# Copia el resto del código de la aplicación
COPY . .

# Expone el puerto
EXPOSE 8000

# Comando por defecto
CMD ["php", "artisan", "migrate", "--force"]