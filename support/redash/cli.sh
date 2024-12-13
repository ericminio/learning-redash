#!/bin/bash

function api_key {
    docker exec redash-postgres-1 psql postgres -U postgres -c "select name, api_key from users where name='admin'" | grep admin | cut -d'|' -f2 | sed 's/ *//g'
}

function create_query {
    local apiKey=$(api_key)
    curl \
        --request POST \
        --header "Authorization: Key $apiKey" \
        --header "Content-Type: application/json" \
        --data '{
            "name": "All products",
            "query": "SELECT * FROM products", 
            "data_source_id": 1
        }' \
        -L \
        -s \
        http://localhost:5000/api/queries 
}

function create_job {
    local apiKey=$(api_key)
    curl \
        --request POST \
        --header "Authorization: Key $apiKey" \
        --header "Content-Type: application/json" \
        --data '{
            "max_age": 0
        }' \
        -L \
        -s \
        http://localhost:5000/api/queries/$1/results 
}

function read_job {
    local apiKey=$(api_key)
    curl \
        --request GET \
        --header "Authorization: Key $apiKey" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        http://localhost:5000/api/jobs/$1
}

function read_query_result_as_csv {   
    local apiKey=$(api_key)
    curl \
        --request GET \
        --header "Authorization: Key $apiKey" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        http://localhost:5000/api/query_results/$1.csv
}

function read_query_result_as_json {   
    local apiKey=$(api_key)
    curl \
        --request GET \
        --header "Authorization: Key $apiKey" \
        --header "Content-Type: application/json" \
        -L \
        -s \
        http://localhost:5000/api/query_results/$1.json
}

function job_ready {
    read_job $1 | json_extract "status" | grep "3" | wc -l
}

