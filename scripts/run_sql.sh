#!/usr/bin/env bash

set -euo pipefail

echo "running $(psql --version)"
input="${1}"

echo "reading file ${input}"

#secrets=$(jq -r 'to_entries|map("-v \(.key)=\"\(.value|tostring)\"")| join(" ")' "${2}")

while IFS= read -r line || [ -n "${line}" ]; do
  echo "${line}"
  if [[ "${line}" =~ ^\s*# || "${line}" =~ ^\s*$ ]]; then
    echo "skipping"
  elif [[ "${line}" =~ create_database ]]; then
    echo "psql -d postgres --file ${line} -v dbname=personify"
    psql -d postgres --file "${line}" -v dbname=personify
  else
    echo "psql --dbname personify --file ${line} -v cashflow_admin_password=secret_password"
    psql --dbname personify --file "${line}" -v cashflow_admin_password=secret_password
  fi
done < "$input"

exit 0
