#!/bin/bash

path="$1"
if [ -z "$path" ]; then
    path="about"
fi

clear
./support/testing/test.sh $path