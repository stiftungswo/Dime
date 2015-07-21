#!/bin/bash

# drops the dime database and loads fixtures from dime.sql

cd /vagrant
mysql -u dime -pdime -e "DROP DATABASE dime; CREATE DATABASE dime;"
mysql -u dime -pdime dime < /vagrant/env/fixtures/dime.sql
