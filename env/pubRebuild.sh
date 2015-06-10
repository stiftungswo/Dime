#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

rm -rf $APP_ROOT/src/Dime/FrontendBundle/Resources/public/build
$SCRIPT_PATH/pub.sh build