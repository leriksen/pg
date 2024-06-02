export PGPASSWORD=$(cat .pgpass)
export PGUSER=psqladmin
export PGPORT=5432
export PGHOST=localhost
export PGSSLMODE=prefer
export PGDATABASE=personify
export INIT_MIGRATE=false
export DRY_RUN=--dry-run
export MIGRATE_DIRECTION=up

