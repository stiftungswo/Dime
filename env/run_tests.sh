#!/bin/bash
set -x

/vagrant/env/fixtures/load_fixtures.sh

/vagrant/vendor/phpunit/phpunit/phpunit -c /vagrant/app/
