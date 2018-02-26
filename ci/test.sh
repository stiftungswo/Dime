#!/bin/bash -vue

if [[ $TRAVIS_COMMIT_MESSAGE != *"[skip-tests]"* ]]; then
  vendor/phpunit/phpunit/phpunit -c app --coverage-clover=coverage.xml
fi
