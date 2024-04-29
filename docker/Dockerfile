FROM alpine:latest
CMD ["/bin/sh"]
RUN apk --no-cache add postgresql-client curl

COPY sql/ /sql/
COPY scripts/run_sql.sh /scripts

CMD [ "/scripts/run_sql.sh", "/sql" ]
