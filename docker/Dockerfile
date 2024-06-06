FROM node:alpine

RUN apk add bash envsubst

RUN npm install -g db-migrate db-migrate-pg

COPY scripts/migrate_sql.sh /scripts/
RUN chmod 755 /scripts/migrate_sql.sh

COPY migrations/ /migrations/

ENTRYPOINT [ "/scripts/migrate_sql.sh", "/migrations", ">", "/var/log/1.log", "2>&1" ]
