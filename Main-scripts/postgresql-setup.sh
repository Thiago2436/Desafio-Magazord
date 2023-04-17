#!/bin/bash

sudo apt-get update
sudo apt-get install -y postgresql

sudo -u postgres psql -c "CREATE DATABASE testdb;"
sudo -u postgres psql -d testdb -c "CREATE TABLE table1 (column1 integer, column2 integer);"
sudo -u postgres psql -d testdb -c "INSERT INTO table1 (column1) SELECT a.column1 FROM generate_series(1, 1000000) AS a (column1);"
