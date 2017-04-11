#!/bin/bash
set -x
ENV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$ENV_DIR/fixtures/load_fixtures.sh
rm -rf ../test-coverage

# generate coverage with xdebug
$ENV_DIR/../vendor/phpunit/phpunit/phpunit -c $ENV_DIR/../app/ --coverage-html $ENV_DIR/../test-coverage "$@"

if [ -d "$ENV_DIR/../test-coverage" ]; then
    echo -e "\n\n  Code Coverage Report written to: $ENV_DIR/../test-coverage\n\n"
fi
