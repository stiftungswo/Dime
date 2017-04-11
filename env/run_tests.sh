#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

$ROOT_DIR/env/fixtures/flush_db.sh
$ROOT_DIR/env/fixtures/load.sh

# run tests
$ROOT_DIR/vendor/phpunit/phpunit/phpunit -c $ROOT_DIR/app/ "$@"
