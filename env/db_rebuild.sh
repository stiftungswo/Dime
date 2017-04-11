#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

$ROOT_DIR/env/fixtures/flush_db.sh

# rebuild the schema
# php ${ROOT_DIR}/app/console doc:data:drop --force
# php ${ROOT_DIR}/app/console doc:data:create
php ${ROOT_DIR}/app/console doc:schema:create
# php ${ROOT_DIR}/app/console doc:fix:load -n

$ROOT_DIR/env/fixtures/load.sh
