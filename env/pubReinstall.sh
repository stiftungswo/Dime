#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

if [ -d ${PUB_CACHE} ]; then
    rm -rf ${PUB_CACHE}
fi

$ROOT_DIR/env/pubget.sh
