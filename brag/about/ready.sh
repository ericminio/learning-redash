#!/bin/bash

source ./support/redash/apikey.sh
source ./support/redash/cli.sh
source ./support/postgres/cli.sh
source ./support/testing/utils.sh
source ./support/testing/dir.sh
source ./support/testing/waiting.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://localhost:5000"

function test_ready {
    actual="42"

    assertequals "$actual" "42" 
}

