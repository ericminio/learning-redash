#!/bin/bash

source ./support/redash/cli.sh
source ./support/testing/utils.sh
source ./support/testing/waiting.sh

function test_can_read_data {
    populate_data_source

    echo "Creating Redash query"
    queryId=$(create_query | json_extract "id")
    jobId=$(create_job $queryId | json_extract "id")

    waiting "Query result from Redash" job_ready $jobId

    queryResultId=$(read_job $jobId | json_extract "query_result_id")
    actual=$(read_query_result_as_csv $queryResultId | tail -n +2 | oneliner)
    echo "Actual: $actual"

    assertequals "1,mouse2,keyboard" "$actual"
}

function populate_data_source {
    docker exec pg psql exploration -U dev -q -c "drop table if exists products"

    docker exec pg psql exploration -U dev -q -c "create table products(id serial primary key, name text)"
    docker exec pg psql exploration -U dev -q -c "insert into products(id, name) values (1, 'mouse'),(2, 'keyboard')"

    echo "Data source populated"
    docker exec pg psql exploration -U dev -q -c "select * from products"
}