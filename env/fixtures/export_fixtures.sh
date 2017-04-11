#!/bin/bash

mysqldump --host=mysql -u dime -pdime dime > ../env/fixtures/dime.sql
