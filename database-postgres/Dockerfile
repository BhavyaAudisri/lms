FROM postgres:16

COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY init_db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
