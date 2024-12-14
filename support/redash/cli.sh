#!/bin/bash

function create_query {
    local name=$1
    local query=$2
    curl \
        --request POST \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        --data '{
            "name": "'"$name"'",
            "query": "'"$query"'", 
            "data_source_id": 1
        }' \
        -L \
        -s \
        $REDASH_BASE_URL/api/queries 
}

function create_job {
    curl \
        --request POST \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        --data '{
            "max_age": 0
        }' \
        -L \
        -s \
        $REDASH_BASE_URL/api/queries/$1/results 
}

function read_job {
    curl \
        --request GET \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        $REDASH_BASE_URL/api/jobs/$1
}

function read_query_result_as_csv {   
    curl \
        --request GET \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        $REDASH_BASE_URL/api/query_results/$1.csv
}

function read_query_result_as_json {   
    curl \
        --request GET \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        $REDASH_BASE_URL/api/query_results/$1.json
}

function job_ready {
    read_job $1 | json_extract "status" | grep "3" | wc -l
}

