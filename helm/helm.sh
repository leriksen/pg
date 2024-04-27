#!/usr/bin/env bash

set -euo pipefail

helm package --version 0.1.0 --app-version 20240427.7 postgres-secrets
helm upgrade --namespace dev --install --values postgres-secrets/values.yaml --wait --install --create-namespace --timeout 30s postgres postgres-secrets-0.1.0.tgz --version 0.1.0