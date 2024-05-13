#!/usr/bin/env bash

set -euo pipefail

input="${1}"

echo "reading file ${input}"

secrets=$(jq -r 'to_entries|map("--set \(.key)=\(.value|tostring)")| join(" ")' "${2}")

while IFS= read -r line || [ -n "${line}" ]; do
  cat "${line}"
  echo

  if [[ "${line}" =~ ^\s*# ]]; then
    echo "line is a comment"
  elif [[ "${line}" =~ ^\s*$ ]]; then
    echo "line is empty"
  elif [[ "${line}" =~ create_database ]]; then
    echo "line is database create, run without -d"

    psql --set dbname=personify -f "${line}"
  else
    echo "line is a sql script, run with specified database"

    psql --dbname personify --file "${line}" "${secrets}"
  fi
done < "$input"

exit 0
