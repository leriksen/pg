#!/usr/bin/env bash

set -euo pipefail

helm package --version 0.1.0 --app-version 20240427.7 postgres
helm upgrade --namespace dev --install --values postgres/values.yaml --wait --install --create-namespace --timeout 30s postgres postgres-0.1.0.tgz --version 0.1.0