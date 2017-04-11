#!/usr/bin/env bash
CURRENT_DIR=$(pwd)
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

cd $ROOT_DIR/src/Dime/FrontendBundle/Resources/public
/usr/lib/dart/bin/pub $@
chmod -R +rx $PUB_CACHE
cd $CURRENT_DIR
