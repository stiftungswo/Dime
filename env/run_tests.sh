#!/bin/bash
set -x

/vagrant/env/fixtures/load_fixtures.sh

/vagrant/vendor/phpunit/phpunit/phpunit -c /vagrant/app/

# with coverage:
#phpunit -c /vagrant/app/ --coverage-html /vagrant/test-coverage
