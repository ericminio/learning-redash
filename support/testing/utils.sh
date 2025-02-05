#!/bin/bash

function oneliner {
    tr -d '\r' | tr -d '\n'
}
function join {
    tr -d '\r' | paste -s -d "," -
}

function shrink {
    sed -E 's/\s+/ /g'
}
function trim {
    sed 's/ *//g'
}

function opening {
    sed -E 's/\{\s*/{ /g'
}
function closing {
    sed -E 's/\s*\}/ }/g'
}
function comma {
    sed -E 's/,\s*/, /g'
}
function colon {
    sed -E 's/:\s+/:/g'
}
function json {
    oneliner | opening | closing  | comma | colon | trim
}
function json_extract {
    grep -o "\"$1\":[^,}]*" | head -1 | cut -d':' -f2 | trim | sed 's/"//g'
}

function remove_first_line {
    tail -n +2
}

