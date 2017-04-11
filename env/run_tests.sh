#!/bin/bash
set -x
ENV_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$ENV_DIR/fixtures/load_fixtures.sh
$ENV_DIR/../vendor/phpunit/phpunit/phpunit -c $ENV_DIR../app/ "$@"
