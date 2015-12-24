FROM php:7.0-apache
MAINTAINER Fabrizio Balliano <fabrizio@fabrizioballiano.com>

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev \
    git \
    vim \
    wget \
    lynx \
  && apt-get clean

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  gd \
  intl \
  mbstring \
  mcrypt \
  pdo_mysql \
  xsl \
  zip \
  opcache

RUN a2enmod rewrite
RUN usermod -u 501 www-data
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -o n98-magerun2.phar http://files.magerun.net/n98-magerun2-latest.phar; chmod +x ./n98-magerun2.phar; mv n98-magerun2.phar /usr/local/bin/
RUN mkdir /root/.composer

ADD opcache.ini /usr/local/etc/php/conf.d/999-opcache.ini
