#!/bin/bash

source ./support/redash/cli.sh

function redash_api_key {
    docker exec redash-postgres-1 psql postgres -U postgres -c "select name, api_key from users where name='admin'" | grep admin | cut -d'|' -f2 | sed 's/ *//g'
}

function redash_data_source_id {
    read_data_sources | json_extract "id"
}

function fetch_as_csv {
    local sql="$1"
    local dsId=$(redash_data_source_id)
    local queryId=$(create_query $dsId "Fetch as csv" "$1" | json_extract "id")
    local jobId=$(create_job $queryId | json_extract "id")
    waiting "Query result from Redash" job_ready $jobId
    local queryResultId=$(read_job $jobId | json_extract "query_result_id")
    
    read_query_result_as_csv $queryResultId
}