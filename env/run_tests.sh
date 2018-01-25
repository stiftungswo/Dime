#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

$ROOT_DIR/env/fixtures/flush_db.sh
$ROOT_DIR/env/fixtures/load.sh

# run tests
export XDEBUG_CONFIG="idekey=phpunit"
export PHP_IDE_CONFIG="serverName=_"
$ROOT_DIR/vendor/phpunit/phpunit/phpunit -c $ROOT_DIR/app/ "$@"
