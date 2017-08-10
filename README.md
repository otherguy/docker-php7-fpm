# PHP 7.2 FPM

All-purpose PHP-FPM 7.2 Docker image. Find it on [Dockerhub](https://hub.docker.com/r/winternight/php7-fpm/builds/).

`$ docker pull winternight/php7-fpm:7.2`

## Description

This is a docker image for an all-purpose PHP-FPM (PHP Version 7.2) container.  It is based on the `7.2-alpine` tag of the [official PHP Docker image](https://hub.docker.com/_/php/). [Patch version](http://semver.org) upgrades are thus done automatically on build (e.g. `7.0.11` to `7.0.12`) but for minor version upgrades (e.g. `7.2.x` to `7.3.x`), a new Dockerfile should be created and tagged appropriately.

## New and Removed Features

There are some new features and deprecated parts in PHP 7.2 that made changes to the Dockerfile necessary:

* `mcrypt` has been [deprecated in 7.1 and removed in 7.2](http://php.net/manual/en/migration71.deprecated.php) in favor of OpenSSL

## Extensions

The installed extensions are enough for [Laravel 5 projects](https://laravel.com) as long as the project is using MySQL. If you need other database drivers/extensions, please fork this image.

This is the full list of preinstalled PHP extensions in this image:

- `ctype`
- `curl`
- `dom`
- `gd`
- `hash`
- `iconv`
- `intl`
- `json`
- `mbstring`
- `mcrypt`
- `mysqli`
- `opcache`
- `pdo`
- `pdo_mysql`
- `phar`
- `posix`
- `session`
- `simplexml`
- `sockets`
- `tokenizer`
- `xml`
- `xmlrpc`
- `xmlwriter`
- `zip`

## Building

In order to build this image yourself, simply run the following command:

`$ docker build -t winternight/php7-fpm:7.2 .`