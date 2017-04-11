#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
CURRENT_DIR=$(pwd)
set -x

# generates new fixtures from with Alice and saves them into dime.sql
cd $ROOT_DIR
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
php app/console h4cc_alice_fixtures:load:sets
mysqldump --host=mysql -u dime -pdime dime > $ROOT_DIR/env/fixtures/dime.sql
cd $CURRENT_DIR
