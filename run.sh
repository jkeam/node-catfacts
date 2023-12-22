#!/bin/bash

DB_URL="postgres://catuser:catuserpassword@$(oc get svc psql -o jsonpath={.spec.clusterIP}):5432/catfacts" node ./app.js
