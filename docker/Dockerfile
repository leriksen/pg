FROM alpine:latest
CMD ["/bin/sh"]
RUN apk --no-cache add postgresql-client

# docker build --tag psql .
# docker run -dit -e PGPASSWORD="$(cat ../terraform/.pgpass)" --name psql1 psql
# docker exec -it psql1 psql -h leifpg.postgres.database.azure.com -U psqladmin -d db -c 'select version();'

# then

# docker push leriksen/psql:0.0.1
# docker run -dit -e PGPASSWORD="$(cat ../terraform/.pgpass)" --name psql1 leriksen/psql:0.0.1
# docker exec -it psql1 psql -h leifpg.postgres.database.azure.com -U psqladmin -d db -c 'select version();'