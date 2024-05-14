FROM node:current-alpine3.19

RUN apk --no-cache add postgresql-client bash jq

COPY scripts/run_sql.sh /scripts/
COPY fixtures/secrets.json /mnt/secrets/secrets.json
COPY sql/ /sql/

ENTRYPOINT [ "/scripts/run_sql.sh", "/sql/manifest.txt", "/mnt/secrets/secrets.json", ">", "/var/log/1.log" ]
