#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

cd $APP_ROOT/src/Dime/FrontendBundle/Resources/public
/usr/lib/dart/bin/pub $@
chmod -R +rx $PUB_CACHE
cd $SCRIPT_PATH
