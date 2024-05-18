export PGPASSWORD=$(cat .pgpass)
export PGUSER=psqladmin
export PGHOST=$(az postgres flexible-server list -g pg | jq -r '.[0].fullyQualifiedDomainName')
export PGPORT=5432
export UMI=$(az identity show -g MC_pg_pg_australiasoutheast -n azurekeyvaultsecretsprovider-pg --query clientId --output tsv)
