#!/usr/bin/env bash

set -euo pipefail


input="manifest.txt"

base_directory="${1}"

cd "${base_directory}"

echo "reading file ${input} from ${base_directory}"

pwd

ls -al

while IFS= read -r line
do
  echo "$line"

  if [[ "${line}" =~ ^\s*# ]]; then
    echo "line is a comment"
  elif [[ "${line}" =~ ^\s*$ ]]; then
    echo "line is empty"
  else
    echo "process ${line}"
    psql --file "${line}"
  fi
done < "$input"
