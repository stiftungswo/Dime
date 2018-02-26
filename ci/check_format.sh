#!/bin/bash -vu
# checks if formatters could have been run locally to fix the code style

# check backend
composer global require "squizlabs/php_codesniffer=*"
# we run phpcbf twice to check if it was able to fix something
# since it reports more than it can fix we check the status code twice and check if it changed
# sadly there is no unique status code for "phpcbf fixed something and maybe there are unfixable errors"
$HOME/.composer/vendor/bin/phpcs --standard=psr2 --extensions=php --ignore=src/Tbbc/MoneyBundle,src/Money,src/Dime/FrontendBundle/Resources/public src
code1=$?
$HOME/.composer/vendor/bin/phpcs --standard=psr2 --extensions=php --ignore=src/Tbbc/MoneyBundle,src/Money,src/Dime/FrontendBundle/Resources/public src > /dev/null 2>&1
code2=$?
if [ $code1 -ne $code2 ]; then
  echo "PHP backend is not properly formatted. Please reformat and commit again. See https://github.com/stiftungswo/Dime/tree/master#formatting"
  exit 1;
fi

# check frontend
cd src/Dime/FrontendBundle/Resources/public
../../../../../dart-sdk/bin/dartfmt -n --line-length 140 --set-exit-if-changed lib/
if [ $? -ne 0 ]; then
  echo "Dart frontend is not properly formatted. Please reformat and commit again. See https://github.com/stiftungswo/Dime/tree/master#formatting"
  exit 1;
fi
