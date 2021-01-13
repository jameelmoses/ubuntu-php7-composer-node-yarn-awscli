FROM ubuntu:focal
MAINTAINER Jameel Moses <hello@jameelmoses.com>
ENV DEBIAN_FRONTEND noninteractive

# Remove sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  gpg-agent \
  build-essential \
  curl \
  git \
  language-pack-en-base \
  libbz2-dev \
  libc6-dev \
  libgdbm-dev \
  libncursesw5-dev \
  libreadline-gplv2-dev \
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
  php7.4 \
  php7.4-cgi \
  php7.4-cli \
  php7.4-common \
  php7.4-curl \
  php7.4-dev \
  php7.4-gd \
  php7.4-gmp \
  php7.4-json \
  php7.4-ldap \
  php7.4-mysql \
  php7.4-odbc \
  php7.4-opcache \
  php7.4-pspell \
  php7.4-readline \
  php7.4-sqlite3 \
  php7.4-tidy \
  php7.4-xmlrpc \
  php7.4-xsl \
  php7.4-fpm \
  php7.4-intl \
  php7.4-mbstring \
  php7.4-zip \
  php-xdebug

# Install latest Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Install yarn
RUN npm install --global yarn

# Clean apt
RUN apt-get clean

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer creates=/usr/local/bin/composer

# Misc
RUN mkdir -p ~/.ssh
RUN [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
