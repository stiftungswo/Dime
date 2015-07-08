#!/bin/bash
WEBROOT=$1
COMPOSERDIR=$2
cd $WEBROOT
php $COMPOSERDIR/composer.phar install
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
mysql -u dime -pdime dime < env/fixtures/dime.sql
php app/console assetic:dump
php app/console asset:install --symlink
/vagrant/env/pubInstall.sh
