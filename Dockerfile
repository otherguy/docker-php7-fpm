# From PHP 7.1 FPM based on Alpine Linux
FROM php:7.1-fpm-alpine

# Maintainer
MAINTAINER Alexander Graf <hi@basecamp.tirol>

# Install dependencies
RUN apk --update add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
      shadow curl curl-dev libmcrypt-dev libxml2-dev freetype-dev libpng-dev libjpeg-turbo-dev imagemagick-dev icu-dev openssl-dev \
      gcc g++ autoconf make \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && yes '' | pecl install apcu-5.1.8 \
    && docker-php-ext-install ctype curl dom gd hash iconv intl json mbstring mcrypt mysqli opcache pdo pdo_mysql phar posix session simplexml sockets tokenizer xml xmlrpc xmlwriter zip \
    && docker-php-ext-enable apcu \
    && apk del gcc g++ autoconf make \
    && rm -rf /var/cache/apk/*

# PHP Config
COPY conf/*.ini /usr/local/etc/php/conf.d/

# Disable access log for php-fpm
RUN sed -e '/access.log/s/^/;/' -i /usr/local/etc/php-fpm.d/docker.conf
RUN echo -e "[PHP]\nlog_errors = yes" > /usr/local/etc/php/conf.d/errorlog.ini

# Hack to change uid of 'www-data' to 1000
RUN usermod -u 1000 www-data

# Change working directory
WORKDIR /srv

# PHP config directory is a volume
VOLUME /usr/local/etc/php/conf.d/

# UTF-8 default
ENV LANG en_US.utf8
