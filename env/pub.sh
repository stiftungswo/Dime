#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

# store cache in vagrant/env/.pub_cache directory to allow access by apache
export PUB_CACHE=${SCRIPT_PATH}/.pub_cache

cd $APP_ROOT/src/Dime/FrontendBundle/Resources/public
/usr/local/dart-sdk/bin/pub $@
chmod -R +rx /vagrant/env/.pub_cache/
cd $SCRIPT_PATH
