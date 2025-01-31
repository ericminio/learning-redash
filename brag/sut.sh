#!/bin/bash

source ./support/postgres/cli.sh

function run_sut {
    execute "update products set flag = true where name = 'keyboard'"
}