FROM alpine:latest

RUN apk --no-cache add postgresql-client bash jq

COPY fixtures/secrets.json /mnt/secrets/secrets.json
COPY scripts/run_sql.sh /scripts/
COPY sql/ /sql/

ENTRYPOINT [ "/scripts/run_sql.sh", "/sql/manifest.txt", "/mnt/secrets/secrets.json", ">", "/var/log/1.log", "2>&1" ]
