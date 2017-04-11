#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
set -x

# drops the dime database and loads fixtures from dime.sql
mysql --host=mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
mysql --host=mysql -u dime -pdime dime < $ROOT_DIR/env/fixtures/dime.sql
