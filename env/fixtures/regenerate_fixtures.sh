#!/bin/bash

# generates new fixtures from with Alice and saves them into dime.sql

cd ../
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
php app/console h4cc_alice_fixtures:load:sets
mysqldump --host=mysql -u dime -pdime dime > ..//env/fixtures/dime.sql
