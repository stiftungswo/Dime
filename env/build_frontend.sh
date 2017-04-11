#!/usr/bin/env bash
set -x
SCRIPT=$(realpath ${BASH_SOURCE[0]})
SCRIPT_PATH=$(dirname ${SCRIPT})
APP_ROOT=$(realpath ${SCRIPT_PATH}/..)

# just call the rebuild script
$SCRIPT_PATH/pubRebuild.sh
