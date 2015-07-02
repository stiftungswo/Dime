#!/bin/bash
WEBROOT=$1
COMPOSERDIR=$2
cd $WEBROOT
php $COMPOSERDIR/composer.phar install
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
php app/console assetic:dump
php app/console h4cc_alice_fixtures:load:sets
php app/console asset:install --symlink
/vagrant/env/pubInstall.sh
