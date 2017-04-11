#!/bin/bash

# drops the dime database and loads fixtures from dime.sql

cd ../
mysql --host=mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
mysql --host=mysql -u dime -pdime dime < ../env/fixtures/dime.sql
