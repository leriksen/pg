FROM alpine:latest
CMD ["/bin/sh"]
RUN apk --no-cache add postgresql-client

COPY sql/ /sql/

CMD [ "psql", "--set=sslmode=require", "-f", "/sql/01_version.sql" ]

# docker build --tag psql .
# docker run --rm -e PGPASSWORD="$(cat ../terraform/.pgpass)" --name psql psql

# then

# docker push leriksen/psql:0.0.1
# docker run --rm -e PGPASSWORD="$(cat ../terraform/.pgpass)" --name psql leriksen/psql:0.0.1