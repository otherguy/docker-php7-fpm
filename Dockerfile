# From PHP 7.4 FPM based on Alpine Linux
FROM php:7.4-fpm-alpine

# Maintainer
LABEL maintainer="Alexander Graf <alex@basecamp.tirol>"

# Install dependencies
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
 && apk add --no-cache curl shadow sqlite curl-dev freetype-dev libpng-dev libjpeg-turbo-dev \
        postgresql-dev imagemagick-dev icu-dev openssl-dev oniguruma-dev libzip-dev

RUN docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd intl mysqli opcache pdo_mysql pdo_pgsql \
 && apk del --no-cache .build-deps $PHPIZE_DEPS \
 && rm -rf /var/cache/apk/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHP Config
COPY conf/*.ini /usr/local/etc/php/conf.d/

# Disable access log for php-fpm
RUN sed -e '/access.log/s/^/;/' -i /usr/local/etc/php-fpm.d/docker.conf
RUN echo -e "[PHP]\nlog_errors = yes" > /usr/local/etc/php/conf.d/errorlog.ini

# Hack to change uid of 'www-data' to 1000
RUN usermod -u 1000 www-data

# Change working directory
WORKDIR /srv

# PHP config directory and /srv are volumes
VOLUME /srv
VOLUME /usr/local/etc/php/conf.d/

# UTF-8 default
ENV LANG en_US.utf8
