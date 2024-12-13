#!/bin/bash

echo "Creating databases"
docker compose run --rm server create_db

echo "starting redash"
docker compose up -d

echo "Creating admin user"
docker exec redash-server-1 ./manage.py \
    users create_root admin@mail.com admin --password=admin123

echo "Creating data source"
docker exec redash-server-1 ./manage.py \
    ds new data --type=pg --options='{"host": "host.docker.internal", "dbname": "exploration", "port": 2345, "user": "dev", "password": "dev" }'

