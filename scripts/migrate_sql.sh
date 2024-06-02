#!/usr/bin/env bash

set -euo pipefail

current=$(pwd)

echo "running db-migrate $(db-migrate --version)"

migrations_dir="${1}"

cd "${migrations_dir}"
echo "moved to $(pwd)"

if [[ "${INIT_MIGRATE:-false}" == "true" ]]; then
  # database-init.json has no db defined, as db:create has a bug,
  # where it doesn't use the name of the db in the json file to create it
  db-migrate db:create "${PGDATABASE}" --env pg --config database_init.json "${DRY_RUN:-}"
fi

# in the absence of the `sponge` utility, this is the safest way to do IPE of the sqls with envsubst
for sql in migrations/sqls/*.sql; do
  echo "updating '${sql}', in place, with envsubst"
  original_file="${sql}"
  tmpfile=$(mktemp)
  touch "${tmpfile}"
  envsubst < "${original_file}" > "${tmpfile}" && mv "${tmpfile}" "${original_file}"
done

db-migrate "${MIGRATE_DIRECTION:-up}" --config database.json --env pg "${DRY_RUN:-}" --verbose

cd "${current}"
echo "returned to $(pwd)"

exit 0
