#!/bin/bash

source ./support/redash/apikey.sh
source ./support/redash/cli.sh
source ./support/postgres/cli.sh
source ./support/testing/utils.sh
source ./support/testing/dir.sh
source ./support/testing/waiting.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://localhost:5000"

function test_can_query {
    executeFile /usr/local/src/schema.sql
    execute "insert into products (id, name) values (1, 'mouse')"
    execute "insert into products (id, name) values (2, 'keyboard')"

    echo "Creating Redash query"
    queryId=$(create_query 1 "All products" "SELECT id, name FROM products" | json_extract "id")
    jobId=$(create_job $queryId | json_extract "id")

    waiting "Query result from Redash" job_ready $jobId

    queryResultId=$(read_job $jobId | json_extract "query_result_id")
    actual=$(read_query_result_as_csv $queryResultId | tail -n +2 | oneliner)    

    assertequals "$actual" "1,mouse2,keyboard" 
}

function test_can_query_with_parameters {
    executeFile /usr/local/src/schema.sql
    execute "insert into products (id, name, description) values (1, 'mouse', 'almost a trumpet')"
    execute "insert into products (id, name, description) values (2, 'keyboard', 'almost a piano')"

    echo "Creating Redash query"
    queryId=$(create_query 1 "Keyboard description" "SELECT description FROM products where name = '{{ product_name }}'" | json_extract "id")
    jobId=$(create_job $queryId "\"product_name\": \"keyboard\"" | json_extract "id")
    
    waiting "Query result from Redash" job_ready $jobId
    
    queryResultId=$(read_job $jobId | json_extract "query_result_id")
    actual=$(read_query_result_as_csv $queryResultId | tail -n +2 | oneliner)    

    assertequals "$actual" "almost a piano" 
}


