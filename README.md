# PHP 7.4 FPM

_All-purpose PHP-FPM 7.4 Docker image that comes with the most popular extensions._

[![Docker Pulls](https://img.shields.io/docker/pulls/otherguy/php7-fpm?style=flat-square)][dockerhub]
[![Docker Stars](https://img.shields.io/docker/stars/otherguy/php7-fpm?style=flat-square)][dockerhub]
[![Travis CI](https://img.shields.io/travis/com/otherguy/docker-php7-fpm?style=flat-square)][travis]
[![GitHub issues](https://img.shields.io/github/issues/otherguy/docker-php7-fpm?style=flat-square)][issues]
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/otherguy/php7-fpm?style=flat-square)][microbadger]
[![GitHub stars](https://img.shields.io/github/stars/otherguy/docker-php7-fpm?color=violet&style=flat-square)][stargazers]
[![MIT License](https://img.shields.io/github/license/otherguy/docker-php7-fpm?color=orange&style=flat-square)][license]

[dockerhub]: https://hub.docker.com/r/otherguy/php7-fpm/
[travis]: https://travis-ci.com/otherguy/docker-php7-fpm
[license]: https://tldrlegal.com/license/mit-license
[microbadger]: https://microbadger.com/images/otherguy/php7-fpm
[stargazers]: https://github.com/otherguy/php7-fpm/stargazers
[issues]: https://github.com/otherguy/docker-php7-fpm/issues

Don't worry about building complex Docker images for your [Laravel](https://laravel.com), [Lumen](https://lumen.laravel.com)
or other PHP 7.4+ applications. Just use this lightweight and convenient image.

    $ docker pull otherguy/php7-fpm:7.4

## 🌈 Quick Start

### Create your Docker image

Base your Docker image on `otherguy/php7-fpm:7.4`, add your project files and you're ready to go!

```Dockerfile
# Dockerfile
FROM otherguy/php7-fpm:7.4

COPY --chown=www-data:www-data . /srv
```

### Customize PHP settings

If you want to change the PHP configuration or overwrite some defaults, simply create your own
configuration file, have the filename start with a `z` and add it to the image.

```ini
# zz-custom.ini
post_max_size       = 100M
upload_max_filesize = 100M
```

```Dockerfile
# Dockerfile
...
COPY zz-custom.ini /usr/local/etc/php/conf.d/
...
```

### Add PHP extensions

It's simple to add your own extensions to the image!

```Dockerfile
# Dockerfile
...
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
 && pecl install mongodb \
 && docker-php-ext-enable mongodb
...
```

## 📚 Description

This is a docker image for an all-purpose PHP-FPM (PHP Version 7.4) container.  It is based on the `7.4-fpm-alpine`
tag of the [official PHP Docker image](https://hub.docker.com/_/php/). [Patch version](http://semver.org) upgrades
are therefore done automatically on build (e.g. `7.4.11` to `7.4.12`) but for minor version upgrades
(e.g. `7.3.x` to `7.4.x`), a new `Dockerfile` should be created and tagged appropriately.

## 🆕 New and Removed Features

There are some new features and deprecated modules that made changes to the `Dockerfile` necessary:

* `mcrypt` has been [deprecated in 7.1 and removed in 7.2](http://php.net/manual/en/migration71.deprecated.php) in
  favor of OpenSSL
* PHP 7.4 includes many of the extensions that were previously installed manually, so only `gd`, `intl`, `opcache` and
  PDO are installed through this image

## 🧮 Extensions

The installed extensions are enough for [Laravel 8 projects](https://laravel.com/docs/8.x/installation) as long as the project
is using either PostgreSQL, MySQL or SQLite. If you need other database drivers/extensions, please fork this image and submit
a [pull requests](https://github.com/otherguy/docker-php7-fpm/pulls), or simply install it in your own image.

This is the full list of extensions available to PHP in this image:

* `ctype`
* `curl`
* `date`
* `dom`
* `fileinfo`
* `filter`
* `ftp`
* `gd`
* `hash`
* `iconv`
* `intl`
* `json`
* `libxml`
* `mbstring`
* `mysqli`
* `mysqlnd`
* `openssl`
* `pcre`
* `PDO`
* `pdo_mysql`
* `pdo_pgsql`
* `pdo_sqlite`
* `Phar`
* `posix`
* `readline`
* `Reflection`
* `session`
* `SimpleXML`
* `sodium`
* `SPL`
* `sqlite3`
* `standard`
* `tokenizer`
* `xml`
* `xmlreader`
* `xmlwriter`
* `Zend OPcache`
* `zip`
* `zlib`

## 🛠 Building

In order to build this image yourself, simply run the following command:

    $ docker build -t otherguy/php7-fpm:7.4 .

## 🚧 Contributing

[Pull Requests](https://github.com/otherguy/docker-php7-fpm/pulls) are more than welcome!
