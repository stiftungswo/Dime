#!/bin/bash -x
cp app/config/parameters.yml.travis app/config/parameters.yml.dist && \
composer install -n && \
php app/console doctrine:database:create && \
php app/console --no-interaction doctrine:migrations:migrate && \
mysql dime < env/fixtures/dime.sql && \
php app/console assetic:dump && \
php app/console asset:install --symlink --relative
