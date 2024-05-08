FROM alpine:latest

RUN apk --no-cache add postgresql-client bash

COPY sql/ /sql/
COPY scripts/run_sql.sh /scripts/

ENTRYPOINT [ "/scripts/run_sql.sh", "/sql", ">", "/var/log/1.log", "/mnt/secrets/secrets.json"]
