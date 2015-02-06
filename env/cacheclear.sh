#!/bin/bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

PHP_MEMLIMIT="256M"
CACHE_ROOT="/tmp/app"
sudo rm -rf ${CACHE_ROOT}/cache/*/
sudo rm -rf ${CACHE_ROOT}/log/*.log
sudo chmod -R 777 ${CACHE_ROOT}
php -d memory_limit=${PHP_MEMLIMIT} ${APP_ROOT}/app/console cache:clear
php -d memory_limit=${PHP_MEMLIMIT} ${APP_ROOT}/app/console cache:warmup
sudo chown -R apache:vagrant ${CACHE_ROOT} 
