#!/bin/bash

docker run -t --rm \
    -v "./Gemfile:/usr/src/ruby/Gemfile" \
    -v "./tests.sh:/usr/src/ruby/tests.sh" \
    -v "./src:/usr/src/ruby/src" \
    ruby:3.3.0 /usr/src/ruby/tests.sh
    
