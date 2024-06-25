#!/usr/bin/env bash

# Script Environment Variable controls
# INIT_MIGRATE      - boolean - default: false                - database does not exist, create prior to running migrations
# DROP_MIGRATE      - boolean - default: false                - delete database, but only if migrate direction is down
# DRY_RUN           - boolean - default: false                - echo actions that would be run
# VERBOSE           - boolean - default: false                - detailed messages from db_migrate
# MIGRATE_DIRECTION - string  - default: up                   - migrate direction
# MIGRATE_OPTIONS   - string  - default: empty                - migration to move up, or down, to

# External Environmental Variable controls
# Following are passed through to the database.json file
# to control the connection to the Postgresql database instance

# PGUSER     - Postgresql database value
# PGPASSWORD - Postgresql database value
# PGDATABASE - Postgresql database value
# PGHOST     - Postgresql database value
# PGPORT     - Postgresql database value

set -euo pipefail

# set string values based on truth switch
[[ "${VERBOSE:-false}" == "true" ]] && VERBOSE_STR="--verbose" || VERBOSE_STR=""
[[ "${DRY_RUN:-false}" == "true" ]] && DRY_RUN_STR="--dry-run" || DRY_RUN_STR=""

current=$(pwd)
echo "starting in ${current}"

# if we terminate unexpectedly, return to start directory
function restore_entry_dir() {
  cd "${current}"

  echo "returned to $(pwd)"
}

trap restore_entry_dir EXIT

echo "running db-migrate $(db-migrate --version)"

migrations_dir="${1}"

cd "${migrations_dir}"
echo "moved to $(pwd)"

if [[ "${INIT_MIGRATE:-false}" == "true" ]]; then
  # database-init.json has no db defined, as db:create has a bug,
  # where it doesn't use the name of the db in the json file to create it
  echo "running db-migrate db:create ${PGDATABASE} --env pg --config database-init.json ${DRY_RUN_STR:-} ${VERBOSE_STR:-}"
  db-migrate db:create "${PGDATABASE}" --env pg --config database-init.json "${DRY_RUN_STR:-}" "${VERBOSE_STR:-}"
fi

# in the absence of the `sponge` utility, this is the safest way to do IPE of the sqls with envsubst
for sql in migrations/sqls/*.sql; do
#  echo "updating '${sql}', in place, with envsubst"
  original_file="${sql}"
  tmpfile=$(mktemp)
  touch "${tmpfile}"
  envsubst < "${original_file}" > "${tmpfile}" && mv "${tmpfile}" "${original_file}"
done

echo "running db-migrate ${MIGRATE_DIRECTION:-up} ${MIGRATE_OPTION:-} --config database.json --env pg ${DRY_RUN_STR:-} ${VERBOSE_STR:-}"
db-migrate "${MIGRATE_DIRECTION:-up}" "${MIGRATE_OPTION:-}" --config database.json --env pg "${DRY_RUN_STR:-}" "${VERBOSE_STR:-}"

# handle case of wanting to drop the entire database
if [[ "${DROP_MIGRATE:-false}" == "true" ]] && [[ "${MIGRATE_DIRECTION:-up}" == "down" ]]; then
  # commented out for now, maybe dropping should be manual, at least initially
  # db-migrate db:drop "${PGDATABASE}" --env pg --config database-init.json "${DRY_RUN_STR:-}" "${VERBOSE_STR:-}"
  echo "Dropping is manual, for now"
fi

exit 0
