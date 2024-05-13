export PGPASSWORD=$(cat .pgpass)
export PGUSER=psqladmin
export PGHOST=$(az postgres flexible-server list -g pg | jq -r '.[0].fullyQualifiedDomainName')
export PGPORT=5432
