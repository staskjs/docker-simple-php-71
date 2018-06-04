FROM ubuntu:16.04 AS simple-php-71

RUN apt-get update

RUN apt-get install -y \
			git \
			vim \
			software-properties-common \
			python-software-properties \
			curl

# Install nginx
RUN apt-get install -y nginx

# Install PHP
RUN LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y \
			php7.1-fpm \
			php7.1-cli \
			php7.1-common \
			php7.1-mbstring \
			php7.1-gd \
			php7.1-intl \
			php7.1-xml \
			php7.1-mysql \
			php7.1-pdo \
			php7.1-opcache \
			php7.1-zip \
			php7.1-dev \
			php7.1-curl

RUN mkdir -p /run/php

RUN sed -i -- "s/;clear_env = no/clear_env = no/g" /etc/php/7.1/fpm/pool.d/www.conf

# Install composer
RUN cd /opt && curl -sS https://getcomposer.org/installer -o composer-setup.php && php composer-setup.php --install-dir=/usr/bin --filename=composer && rm composer-setup.php

EXPOSE 80 443