#!/usr/bin/env bash

set -euo pipefail

echo "terraform init ${*}"

terraform init "${@}"
