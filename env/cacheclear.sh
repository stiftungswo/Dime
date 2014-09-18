#!/bin/bash
set -x
PHP_MEMLIMIT="256M"
CACHE_ROOT="/tmp/app"
sudo rm -rf ${CACHE_ROOT}/cache/*/
sudo rm -rf ${CACHE_ROOT}/log/*.log
sudo chmod -R 777 ${CACHE_ROOT}
php -d memory_limit=${PHP_MEMLIMIT} app/console cache:clear
php -d memory_limit=${PHP_MEMLIMIT} app/console cache:warmup
sudo chown -R apache:vagrant ${CACHE_ROOT} 
