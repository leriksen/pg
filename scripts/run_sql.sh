#!/usr/bin/env bash

set -euo pipefail

input="${1}"

echo "reading file ${input}"

secrets=$(jq -r 'to_entries|map("--set=\(.key)=\(.value|tostring)")| join(" ")' "${2}")

while IFS= read -r line || [ -n "${line}" ]; do
  echo "${line}"
  if [[ "${line}" =~ ^\s*# || "${line}" =~ ^\s*$ ]]; then
    echo "skipping"
  elif [[ "${line}" =~ create_database ]]; then
    psql --dbname=template1 --file "${line}" "${secrets}"
  else
    psql --dbname personify --file "${line}" "${secrets}"
  fi
done < "$input"

exit 0
