#!/bin/sh
export MC="-j$(nproc)"
#
# Install extension from package file(.tgz),
# For example:
#
# installExtensionFromTgz redis-5.2.2
#
# Param 1: Package name with version
# Param 2: enable options
#
installExtensionFromTgz()
{
    tgzName=$1
    extensionName="${tgzName%%-*}"

    mkdir ${extensionName}
    tar -xf ${tgzName}.tgz -C ${extensionName} --strip-components=1
    ( cd ${extensionName} && phpize && ./configure && make ${MC} && make install )

    docker-php-ext-enable ${extensionName} $2
}

echo "---------- Install bcmath ----------"
docker-php-ext-install ${MC} bcmath

echo "---------- Install pdo_mysql ----------"
docker-php-ext-install ${MC} pdo_mysql

echo "---------- Install pcntl ----------"
docker-php-ext-install ${MC} pcntl

echo "---------- Install mysqli ----------"
docker-php-ext-install ${MC} mysqli

echo "---------- Install exif ----------"
docker-php-ext-install ${MC} exif

echo "---------- Install calendar ----------"
docker-php-ext-install ${MC} calendar

echo "---------- Install zend_test ----------"
docker-php-ext-install ${MC} zend_test

echo "---------- Install opcache ----------"
docker-php-ext-install opcache

echo "---------- Install sockets ----------"
docker-php-ext-install ${MC} sockets


echo "---------- Install gettext ----------"
apk --no-cache add gettext-dev
docker-php-ext-install ${MC} gettext

echo "---------- Install shmop ----------"
docker-php-ext-install ${MC} shmop

echo "---------- Install sysvmsg ----------"
docker-php-ext-install ${MC} sysvmsg

echo "---------- Install sysvsem ----------"
docker-php-ext-install ${MC} sysvsem

echo "---------- Install sysvshm ----------"
docker-php-ext-install ${MC} sysvshm

echo "---------- Install gd ----------"
options="--with-freetype --with-jpeg --with-webp"
apk add --no-cache \
        freetype \
        freetype-dev \
        libpng \
        libpng-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
	libwebp-dev \
    && docker-php-ext-configure gd ${options} \
    && docker-php-ext-install ${MC} gd \
    && apk del \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev

echo "---------- Install bz2 ----------"
apk add --no-cache bzip2-dev
docker-php-ext-install ${MC} bz2


echo "---------- Install soap ----------"
apk add --no-cache libxml2-dev
docker-php-ext-install ${MC} soap

echo "---------- Install xsl ----------"
apk add --no-cache libxml2-dev libxslt-dev
docker-php-ext-install ${MC} xsl


echo "---------- Install xmlrpc ----------"
apk add --no-cache libxml2-dev libxslt-dev
docker-php-ext-install ${MC} xmlrpc

echo "---------- Install zip ----------"
# Fix: https://github.com/docker-library/php/issues/797
apk add --no-cache libzip-dev
docker-php-ext-configure zip --with-libzip=/usr/include




echo "---------- Install redis ----------"
installExtensionFromTgz redis-5.2.2

echo "---------- Install mongodb ----------"
installExtensionFromTgz mongodb-1.7.4

echo "---------- Install apcu ----------"
installExtensionFromTgz apcu-5.1.17

echo "---------- Install swoole ----------"
installExtensionFromTgz swoole-4.5.2