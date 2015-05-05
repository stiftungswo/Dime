#!/bin/bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
sudo chmod -R 777 /tmp/app
composer.phar update $@
${SCRIPT_PATH}/cacheclear.sh
