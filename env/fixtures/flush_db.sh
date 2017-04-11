#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
set -x

# drops the dime database
mysql --host=mysql -u root -e "DROP DATABASE IF EXISTS dime; CREATE DATABASE dime;"
mysql --host=mysql -u root -e "GRANT all privileges on dime.* to dime@'%' IDENTIFIED BY 'dime';"
mysql --host=mysql -u root -e "FLUSH PRIVILEGES;"
