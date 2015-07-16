#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

if [ -d ${SCRIPT_PATH}/.pub_cache ]; then
    rm -rf ${SCRIPT_PATH}/.pub_cache
fi

if [ -d $APP_ROOT/src/Dime/FrontendBundle/Resources/public/packages ]; then
    rm -rf $APP_ROOT/src/Dime/FrontendBundle/Resources/public/packages
fi

$SCRIPT_PATH/pub.sh get