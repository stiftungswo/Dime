#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

php ${ROOT_DIR}/app/console doc:data:drop --force
php ${ROOT_DIR}/app/console doc:data:create
php ${ROOT_DIR}/app/console doc:schema:create
php ${ROOT_DIR}/app/console doc:fix:load -n
