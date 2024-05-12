#!/usr/bin/env bash

set -euo pipefail

input="${1}"

echo "reading file ${input}"

secrets=$(jq -r 'to_entries|map("--\(.key)=\(.value|tostring)")| join(" ")' "${2}")

while IFS= read -r line || [ -n "${line}" ]; do
  echo "$line"

  if [[ "${line}" =~ ^\s*# ]]; then
    echo "line is a comment"
  elif [[ "${line}" =~ ^\s*$ ]]; then
    echo "line is empty"
  else
    echo "process ${line}"

    cat "${line}"
    echo


    echo "psql --file ${line} ${secrets}"
  fi
done < "$input"

exit 0
