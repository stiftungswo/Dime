#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

wget 'https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip' -O /tmp/dart-sdk.zip --no-verbose
sudo unzip -d /usr/local/ /tmp/dart-sdk.zip
sudo chmod -R a+rx /usr/local/dart-sdk
rm /tmp/dart-sdk.zip
sudo chown -R apache:apache $(getent passwd apache | awk '{split($0,a,":"); print a[6]}')
$SCRIPT_PATH/pub.sh update