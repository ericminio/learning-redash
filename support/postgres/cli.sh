#!/bin/bash

function executeFile {
    docker exec pg psql exploration -U dev -q -f $1
}
function execute {
    docker exec pg psql exploration -U dev -q -c "$1"
}