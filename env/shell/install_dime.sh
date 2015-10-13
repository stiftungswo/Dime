#!/bin/bash

# => This script should run as user "vagrant"

cd /vagrant

# copy config files
/bin/cp /vagrant/app/config/parameters.yml.dist /vagrant/app/config/parameters.yml
/bin/cp /vagrant/web/.htaccess_dev /vagrant/web/.htaccess

# install dependencies
php /usr/local/bin/composer.phar install

# prepare database
mysql -u dime -pdime -e "DROP DATABASE IF EXISTS dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
mysql -u dime -pdime dime < env/fixtures/dime.sql

# prepare assets
php app/console assetic:dump
php app/console asset:install --symlink

/vagrant/env/pubInstall.sh
