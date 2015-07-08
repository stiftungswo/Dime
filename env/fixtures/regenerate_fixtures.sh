#!/bin/bash

# generates new fixtures from with Alice and saves them into dime.sql

cd /vagrant
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
php app/console doctrine:schema:create
php app/console h4cc_alice_fixtures:load:sets
mysqldump -u dime -pdime dime > /vagrant/env/fixtures/dime.sql