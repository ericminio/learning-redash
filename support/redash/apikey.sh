#!/bin/bash

function redash_api_key {
    docker exec redash-postgres-1 psql postgres -U postgres -c "select name, api_key from users where name='admin'" | grep admin | cut -d'|' -f2 | sed 's/ *//g'
}