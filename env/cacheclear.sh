#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

rm -rf ${CACHE_ROOT}/cache/*/
rm -rf ${CACHE_ROOT}/log/*.log
chmod -R 777 ${CACHE_ROOT}
php -d memory_limit=${PHP_MEMLIMIT} ${ROOT_DIR}/app/console cache:clear
php -d memory_limit=${PHP_MEMLIMIT} ${ROOT_DIR}/app/console cache:warmup
chmod -R 777 ${CACHE_ROOT}
