#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

if [ -d $ROOT_DIR/src/Dime/FrontendBundle/Resources/public/packages ]; then
    rm -rf $ROOT_DIR/src/Dime/FrontendBundle/Resources/public/packages
fi

$ROOT_DIR/env/pub.sh get
