FROM alpine:latest
CMD ["/bin/sh"]
RUN apk --no-cache add postgresql-client curl

COPY sql/ /sql/
COPY scripts/run_sql.sh /scripts

ENTRYPOINT [ "/scripts/run_sql.sh", "/sql" ]
