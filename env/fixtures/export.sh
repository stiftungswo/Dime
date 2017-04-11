#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
set -x

# dumps data to dime.sql so it can be used as fixtures
mysqldump --host=mysql -u dime -pdime dime > $ROOT_DIR/env/fixtures/dime.sql
