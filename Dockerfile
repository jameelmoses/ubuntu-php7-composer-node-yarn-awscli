FROM ubuntu:latest
MAINTAINER Jameel Moses <jameeloses@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Remove sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  gpg-agent \
  build-essential \
  curl \
  git \
  language-pack-en-base \
  libbz2-dev \
  libc6-dev \
  libjpeg-dev \
  libgdbm-dev \
  libncursesw5-dev \
  libpng-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  nano \
  openssh-client \
  rsync \
  software-properties-common \
  unzip \
  wget \
  zip

# Add repos
RUN add-apt-repository ppa:deadsnakes/ppa
RUN LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php

## Install python and pip
RUN apt-get update && apt-get install -y \
  python3.7 \
  python3-pip

RUN python3 -m pip install --upgrade pip

# Install AWS CLI
RUN pip install awscli --upgrade --user

# Install PHP
RUN apt-get -y --allow-unauthenticated install \
  php8.1 \
  php8.1-cgi \
  php8.1-cli \
  php8.1-common \
  php8.1-curl \
  php8.1-dev \
  php8.1-gd \
  php8.1-gmp \
  php8.1-ldap \
  php8.1-mysql \
  php8.1-odbc \
  php8.1-opcache \
  php8.1-pspell \
  php8.1-readline \
  php8.1-sqlite3 \
  php8.1-tidy \
  php8.1-xmlrpc \
  php8.1-xsl \
  php8.1-fpm \
  php8.1-intl \
  php8.1-mbstring \
  php8.1-zip \
  php-xdebug

# Install latest Node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Install yarn
RUN npm install --global yarn

# Clean apt
RUN apt-get clean

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer creates=/usr/local/bin/composer

# Misc
COPY ssh /root/.ssh
RUN chmod 0700 /root/.ssh
