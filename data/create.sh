#!/bin/bash

docker exec pg psql exploration -U dev -q -c "create table products(id serial primary key, name text)"
docker exec pg psql exploration -U dev -q -c "insert into products(id, name) values (1, 'mouse'),(2, 'keyboard')"

docker exec pg psql exploration -U dev -q -c "select * from products"