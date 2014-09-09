#!/bin/bash
set -ex
WEBROOT=$1
COMPOSERDIR=$2
if [ -f $COMPOSERDIR/composer.phar ]; then
	php $COMPOSERDIR/composer.phar selfupdate
else
	curl -s https://getcomposer.org/installer | php -- --install-dir=$COMPOSERDIR
fi
