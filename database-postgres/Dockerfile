FROM postgres:16

COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY init-db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
