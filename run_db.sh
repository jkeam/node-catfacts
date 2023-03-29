#!/bin/bash

podman run -d --rm --name db \
  -p "5432:5432" \
  -e PGPORT=5432 -e POSTGRESQL_USER=catuser -e POSTGRESQL_PASSWORD=catuserpassword \
  -e POSTGRESQL_DATABASE=catfacts -e POSTGRESQL_MAX_PREPARED_TRANSACTIONS=100 \
  -e POSTGRESQL_MAX_CONNECTIONS=100 -e POSTGRESQL_ADMIN_PASSWORD=root \
  registry.redhat.io/rhel9/postgresql-13:latest

sleep 5
podman cp ./create.sql db:/opt/app-root/src/create.sql
podman exec db psql -U catuser -d catfacts -a -f /opt/app-root/src/create.sql
