#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

cd $APP_ROOT/src/Dime/FrontendBundle/Resources/public
sudo chown -R apache:apache ./
sudo -u apache /usr/local/dart-sdk/bin/pub $@
sudo chown -R vagrant:vagrant ./
cd $SCRIPT_PATH
