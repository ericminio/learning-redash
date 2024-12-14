#!/bin/bash

source ./support/redash/apikey.sh
source ./support/redash/cli.sh
source ./support/postgres/cli.sh
source ./support/testing/utils.sh
source ./support/testing/dir.sh
source ./support/testing/waiting.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://localhost:5000"


function test_can_read_data {
    populate_data_source

    echo "Creating Redash query"
    queryId=$(create_query "All products" "SELECT * FROM products" 1 | json_extract "id")
    jobId=$(create_job $queryId | json_extract "id")

    waiting "Query result from Redash" job_ready $jobId

    queryResultId=$(read_job $jobId | json_extract "query_result_id")
    actual=$(read_query_result_as_csv $queryResultId | tail -n +2 | oneliner)
    echo "Actual: $actual"

    assertequals "$actual" "1,mouse2,keyboard" 
}

function populate_data_source {
    executeFile /usr/local/src/seeds.sql

    echo "Data source populated"
    execute "select * from products"
}

