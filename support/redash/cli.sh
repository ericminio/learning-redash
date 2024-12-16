#!/bin/bash

function create_query {
    curl \
        --request POST \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        --data '{
            "name": "'"$2"'",
            "query": "'"$3"'", 
            "data_source_id": '"$1"'
        }' \
        -L \
        -s \
        $REDASH_BASE_URL/api/queries 
}

function create_job {
    local parameters=$2
    curl \
        --request POST \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        --data '{
            "max_age": 0,
            "parameters": { '"$parameters"' }
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

function read_data_sources {
    curl \
        --request GET \
        --header "Authorization: Key $REDASH_API_KEY" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        $REDASH_BASE_URL/api/data_sources
}