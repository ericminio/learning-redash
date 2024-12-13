#!/bin/bash

source ./__tests__/helpers.sh
source ./__tests__/waiting.sh

function create_query {
    curl \
        --request POST \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        --data '{
            "name": "All products",
            "query": "SELECT * FROM products", 
            "data_source_id": 1
        }' \
        -L \
        http://localhost:5000/api/queries 
}

function create_job {
    curl \
        --request POST \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        --data '{
            "max_age": 0
        }' \
        -L \
        http://localhost:5000/api/queries/$1/results 
}

function read_job {
    curl \
        --request GET \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        -L \
        http://localhost:5000/api/jobs/$1
}

function read_query_result_as_csv {   
    curl \
        --request GET \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        -L \
        http://localhost:5000/api/query_results/$1.csv
}

function job_ready {
    read_job $1 | json_extract "status" | grep "3" | wc -l
}

./data/create.sh

queryId=$(create_query | json_extract "id")
jobId=$(create_job $queryId | json_extract "id")

waiting job job_ready $jobId

queryResultId=$(read_job $jobId | json_extract "query_result_id")
read_query_result_as_csv $queryResultId | tail -n +2