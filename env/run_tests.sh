#!/bin/bash
set -x

# Usage:
# Run all tests:
# ./run_tests.sh
#
# Only run specific tests:
# ./run_tests.sh --filter Offer

/vagrant/env/fixtures/load_fixtures.sh

/vagrant/vendor/phpunit/phpunit/phpunit -c /vagrant/app/ "$@"
