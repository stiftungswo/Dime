#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

$ROOT_DIR/env/fixtures/flush_db.sh
$ROOT_DIR/env/fixtures/load.sh

# clear coverage and regenarate
rm -rf $ROOT_DIR/test-coverage
$ROOT_DIR/vendor/phpunit/phpunit/phpunit -c $ROOT_DIR/app/ --coverage-html $ROOT_DIR/test-coverage "$@"
if [ -d "$ROOT_DIR/test-coverage" ]; then
    echo -e "\n\n  Code Coverage Report written to: $ROOT_DIR/test-coverage\n\n"
fi
