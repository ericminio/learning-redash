#!/bin/bash

./support/run.sh $1
fswatch -o about -o brag -o data -o support/redash -e "run.output" | xargs -n1 ./support/run.sh $1