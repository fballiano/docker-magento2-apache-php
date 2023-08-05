FROM php:8.2-apache
MAINTAINER Fabrizio Balliano <fabrizio@fabrizioballiano.com>

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    libxslt1-dev \
    libonig-dev \
    git \
    vim \
    wget \
    lynx \
    psmisc \
    zip unzip \
  && apt-get clean

RUN docker-php-ext-configure gd --with-freetype --with-jpeg; \
  docker-php-ext-install \
    gd \
    intl \
    mbstring \
    pdo_mysql \
    xsl \
    zip \
    opcache \
    bcmath \
    soap \
    sockets

ADD https://raw.githubusercontent.com/colinmollenhour/credis/master/Client.php /credis.php
ADD php.ini /usr/local/etc/php/conf.d/888-fballiano.ini
ADD register-host-on-redis.php /register-host-on-redis.php
ADD unregister-host-on-redis.php /unregister-host-on-redis.php
ADD start.sh /start.sh

RUN COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN usermod -u 1000 www-data; \
  a2enmod rewrite; \
  curl -o n98-magerun2.phar http://files.magerun.net/n98-magerun2-latest.phar; \
  chmod +x ./n98-magerun2.phar; \
  chmod +x /start.sh; \
  chmod +r /credis.php; \
  mv n98-magerun2.phar /usr/local/bin/; \
  mkdir -p /root/.composer

CMD ["/start.sh"]
