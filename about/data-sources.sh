#!/bin/bash

source ./support/redash/utils.sh
source ./support/redash/cli.sh
source ./support/testing/utils.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://localhost:5000"

function test_can_fetch_data_sources_id_needed_to_create_query {
    local name=$(read_data_sources | json_extract "id" | trim)

    assertequals "$name" "1" 
}
