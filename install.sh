#!/bin/bash

echo 'Assuming you have already installed DevSpaces Operator and are logged in'
echo 'Also assuming you are in the devspace project/namespace'

echo 'creating database'
oc process -p DATABASE_SERVICE_NAME=psql -p POSTGRESQL_USER=catuser -p POSTGRESQL_PASSWORD=catuserpassword -p POSTGRESQL_DATABASE=catfacts -n openshift postgresql-persistent | oc create -f -

echo 'creating adminer'
oc new-app -p ADMINER_DEFAULT_SERVER=localhost -p ADMINER_DESIGN=nette --image=quay.io/official-images/adminer@sha256:a19c46d0b65c0e33cd43e3e0beb3ba197ee66311dafc2aca5952069f9c502319
oc expose service/adminer

echo 'waiting 10s for db to boot completely'
sleep 10

echo 'migrating'
npm install
DB_URL="postgres://catuser:catuserpassword@$(oc get svc psql -o jsonpath={.spec.clusterIP}):5432/catfacts" node ./migrate.js

echo 'adminer is available here:'
echo "http://$(oc get routes/adminer -o jsonpath='{.spec.host}')"

echo ''
