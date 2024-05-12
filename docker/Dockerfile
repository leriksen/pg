FROM node:current-alpine3.19

RUN apk --no-cache add postgresql-client bash jq

RUN npm install -g db-migrate db-migrate-pg

COPY migrations/ /migration/

COPY fixtures/secrets.json /mnt/secrets/secrets.json

ENTRYPOINT [ "db-migrate", "up", "--config", "migations/database.json", "-e", "pg", ">", "/var/log/1.log" ]
