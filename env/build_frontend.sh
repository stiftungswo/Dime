#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

# just call the rebuild script
$ROOT_DIR/env/pub_rebuild.sh
