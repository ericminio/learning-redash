#!/bin/bash

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
        http://localhost:5000/api/queries/1/results 
}

function read_job {
    curl \
        --request GET \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        -L \
        http://localhost:5000/api/jobs/1459a49f-cee9-48de-ae68-6dff6e1e4cb5
}

function read_query_result {   
    curl \
        --request GET \
        --header "Authorization: Key 52Ic6pgnq0P2gSgb0f1V778Y4gH8pu0p1P4J8b5s" \
        --header "Content-Type: application/json" \
        -L \
        http://localhost:5000/api/query_results/2
}
