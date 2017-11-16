#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
set -x

$ROOT_DIR/env/fixtures/flush_db.sh

# rebuild the schema
php ${ROOT_DIR}/app/console doctrine:database:create
php ${ROOT_DIR}/app/console doctrine:migrations:migrate --verbose
