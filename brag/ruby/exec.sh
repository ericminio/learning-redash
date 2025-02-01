#!/bin/bash

source ../../support/redash/cli.sh
source ../../support/redash/utils.sh

export REDASH_API_KEY=$(redash_api_key)
export REDASH_BASE_URL="http://host.docker.internal:5000"

docker run -it --rm \
    -e REDASH_API_KEY \
    -e REDASH_BASE_URL \
    -v "./Gemfile:/usr/src/ruby/Gemfile" \
    -v "./tests.sh:/usr/src/ruby/tests.sh" \
    -v "./src:/usr/src/ruby/src" \
    ruby:3.3.0 bash
    
