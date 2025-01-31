#!/bin/bash

source ./support/redash/utils.sh
source ./support/postgres/cli.sh
source ./support/testing/utils.sh

function run_flag {
    local target=$1
    local rows=$(fetch_as_csv "SELECT id, name FROM products" | remove_first_line)

    for row in $rows; do
        local data=$(echo $row | oneliner)
        local id=$(echo $data | cut -d, -f1)
        local name=$(echo $data | cut -d, -f2)
        if [ "$name" == "$target" ]; then
            execute "update products set flag = true where id = $id"    
        fi
    done
    
}
