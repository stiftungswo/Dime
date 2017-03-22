#!/bin/bash
set -x

/vagrant/env/fixtures/load_fixtures.sh

rm -rf /vagrant/test-coverage

# generate coverage with xdebug
/vagrant/vendor/phpunit/phpunit/phpunit -c /vagrant/app/ --coverage-html /vagrant/test-coverage "$@"

# generate coverage with phpdbg
#phpdbg -dmemory_limit=4096M -qrr /vagrant/vendor/phpunit/phpunit/phpunit -c /vagrant/app/ --coverage-html /vagrant/test-coverage "$@"


if [ -d "/vagrant/test-coverage" ]; then
    echo -e "\n\n  Code Coverage Report written to: /vagrant/test-coverage\n\n"
fi
