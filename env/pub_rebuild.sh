#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

rm -rf $ROOT_DIR/src/Dime/FrontendBundle/Resources/public/build
$ROOT_DIR/env/pub.sh build
