#!/bin/bash
sudo chmod -R 777 /tmp/app
composer.phar update
./cacheclear.sh
