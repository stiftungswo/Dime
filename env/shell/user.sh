#!/bin/bash
set -ex
WEBROOT=$1
COMPOSERDIR=$2
cd $WEBROOT
rm -f composer.lock
php $COMPOSERDIR/composer.phar install
php app/console doctrine:schema:create
php app/console assetic:dump
php app/console doctrine:fixtures:load -n
