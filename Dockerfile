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
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
  docker-php-ext-install \
    gd \
    intl \
    mbstring \
    mcrypt \
    pdo_mysql \
    xsl \
    zip \
    opcache

ADD https://raw.githubusercontent.com/colinmollenhour/credis/master/Client.php /credis.php
ADD opcache.ini /usr/local/etc/php/conf.d/999-opcache.ini
ADD register-host-on-redis.php /register-host-on-redis.php
ADD unregister-host-on-redis.php /unregister-host-on-redis.php
ADD start.sh /start.sh

#RUN usermod -u 501 www-data #this was for dinghy
RUN usermod -u 1000 www-data; \
  a2enmod rewrite; \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
  curl -o n98-magerun2.phar http://files.magerun.net/n98-magerun2-latest.phar; \
  chmod +x ./n98-magerun2.phar; \
  chmod +x /start.sh; \
  chmod +x /credis.sh; \
  mv n98-magerun2.phar /usr/local/bin/; \
  mkdir /root/.composer

CMD ["/start.sh"]
