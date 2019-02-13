FROM ubuntu:bionic
MAINTAINER Jameel Moses <hello@jameelmoses.com>
ENV DEBIAN_FRONTEND noninteractive

# Remove sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  language-pack-en-base \
  nano \
  openssh-client \
  rsync \
  software-properties-common \
  wget

# Add repos
RUN add-apt-repository ppa:deadsnakes/ppa
RUN LC_ALL=en_US.UTF-8 apt-add-repository ppa:ondrej/php

## Instally python and pip
RUN apt-get update && apt-get install -y \
  python3.7 \
  python3-pip

RUN python3 -m pip install --upgrade pip

# Install AWS CLI
RUN pip install awscli --upgrade --user

# Install PHP
RUN apt-get -y --allow-unauthenticated install \
  php7.2 \
  php7.2-cli

# Install latest Node and npm
RUN apt-get install -y --no-install-recommends nodejs npm

# Install yarn and gulp
RUN npm install --global yarn gulp-cli

# Clean apt
RUN apt-get clean

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer creates=/usr/local/bin/composer

# Misc
RUN mkdir -p ~/.ssh
RUN [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
