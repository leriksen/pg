#!/usr/bin/env bash

set -euo pipefail

psql "--host=leifpg01.postgres.database.azure.com" "--port=5432" "--dbname=db" "--username=psqladmin" "--set=sslmode=require" -c 'select version();'

