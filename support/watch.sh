#!/bin/bash

./support/run.sh 
fswatch -o about -o data -o support/redash -e "run.output" | xargs -n1 ./support/run.sh