#!/bin/bash
CURRENT_DIR=$(pwd)
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

cd $ROOT_DIR
composer update $@
${ROOT_DIR}/env/cacheclear.sh
cd $CURRENT_DIR
