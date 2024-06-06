#!/usr/bin/env bash

set -euo pipefail

env

current=$(pwd)

echo "running db-migrate $(db-migrate --version)"

migrations_dir="${1}"

cd "${migrations_dir}"
echo "moved to $(pwd)"

if [[ "${INIT_MIGRATE:-false}" == "true" ]]; then
  # database-init.json has no db defined, as db:create has a bug,
  # where it doesn't use the name of the db in the json file to create it
  echo "running db-migrate db:create ${PGDATABASE} --env pg --config database-init.json ${DRY_RUN:-}"
  db-migrate db:create "${PGDATABASE}" --env pg --config database-init.json "${DRY_RUN:-}"
fi

# in the absence of the `sponge` utility, this is the safest way to do IPE of the sqls with envsubst
for sql in migrations/sqls/*.sql; do
  echo "updating '${sql}', in place, with envsubst"
  original_file="${sql}"
  tmpfile=$(mktemp)
  touch "${tmpfile}"
  envsubst < "${original_file}" > "${tmpfile}" && mv "${tmpfile}" "${original_file}"
done

echo "running db-migrate ${MIGRATE_DIRECTION:-up} ${MIGRATE_OPTION:-} --config database.json --env pg ${DRY_RUN:-} --verbose"
db-migrate "${MIGRATE_DIRECTION:-up}" "${MIGRATE_OPTION:-}" --config database.json --env pg "${DRY_RUN:-}" --verbose

if [[ "${DROP_MIGRATE:-false}" == "true" ]] && [[ "${MIGRATE_DIRECTION:-up}" == "down" ]]; then
  # commented out for now, maybe dropping should be manual, at least initially
  # db-migrate db:drop "${PGDATABASE}" --env pg --config database-init.json "${DRY_RUN:-}"
  echo "Dropping is manual, for now"
fi

cd "${current}"
echo "returned to $(pwd)"

exit 0
