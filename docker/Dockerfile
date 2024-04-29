FROM alpine:latest
CMD ["/bin/sh"]
RUN apk --no-cache add postgresql-client curl

COPY sql/ /sql/
COPY scripts/run_sql.sh /scripts

CMD [ "psql", "--set=sslmode=require", "-f", "/sql/01_version.sql" ]
