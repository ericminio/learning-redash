#!/bin/bash

source ./support/redash/utils.sh
source ./support/redash/cli.sh
source ./support/postgres/cli.sh
source ./support/testing/utils.sh
source ./support/testing/dir.sh
source ./support/testing/waiting.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://localhost:5000"

source ./brag/bash/sut.sh

function test_flagging {
    executeFile /usr/local/src/schema.sql
    executeFile /usr/local/src/seeds.sql
    run_flag "keyboard"
    local flagged=$(execute "select name from products where flag = true" | head -n 3 | tail -n 1 | trim)

    assertequals "$flagged" "keyboard" 
}

