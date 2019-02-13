FROM ubuntu:xenial
MAINTAINER Jameel Moses <hello@jameelmoses.com>
ENV DEBIAN_FRONTEND noninteractive

# Remove sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update
RUN apt-get -y install wget \
  curl \
  git \
  zip \
  unzip \
  libxml2-dev \
  build-essential \
  libssl-dev \
  vim \
  nano \
  openssh-client \
  libreadline-gplv2-dev \
  libncursesw5-dev \
  libsqlite3-dev \
  tk-dev \
  libgdbm-dev \
  libc6-dev \
  libbz2-dev \
  software-properties-common \
  language-pack-en-base \
  ansible \
  apt-transport-https

# Add Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Add repos
RUN add-apt-repository ppa:fkrull/deadsnakes
RUN LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php
RUN apt-get update

# Install python
RUN apt-get install -y python2.7
RUN apt-get install -y python-pip
RUN pip install --upgrade pip

# Install AWS CLI
RUN pip install awscli --upgrade --user

# Install PHP
RUN apt-get -y --allow-unauthenticated install \
  php7.2 \
  php7.2-cgi \
  php7.2-cli \
  php7.2-common \
  php7.2-curl \
  php7.2-dev \
  php7.2-gd \
  php7.2-gmp \
  php7.2-json \
  php7.2-ldap \
  php7.2-mysql \
  php7.2-odbc \
  php7.2-opcache \
  php7.2-pspell \
  php7.2-readline \
  php7.2-sqlite3 \
  php7.2-tidy \
  php7.2-xmlrpc \
  php7.2-xsl \
  php7.2-fpm \
  php7.2-intl \
  php7.2-mcrypt \
  php7.2-mbstring \
  php7.2-zip \
  php-xdebug

# Install node & gulp
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash && \
  export NVM_DIR="/root/.nvm" && \
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
  nvm install node && \

# Install Yarn
RUN apt-get -y install --no-install-recommends yarn
RUN yarn global add gulp-cli

# Clean apt
RUN apt-get clean

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer creates=/usr/local/bin/composer
RUN php /usr/local/bin/composer global require "fxp/composer-asset-plugin:~1.1.1"
RUN php /usr/local/bin/composer global require "hirak/prestissimo:^0.3"

# Misc
RUN mkdir -p ~/.ssh
RUN [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

git push origin :refs/tags/php72-v1.0
