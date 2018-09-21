#!/bin/bash -vue
php app/console doctrine:database:create
mysql dime < env/fixtures/dime.sql
vendor/phpunit/phpunit/phpunit --coverage-clover=coverage.xml --configuration app/phpunit.xml.dist --testsuite $1
bash <(curl -s https://codecov.io/bash)
