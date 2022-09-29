FROM registry.fedoraproject.org/fedora-minimal:36

VOLUME ["/var/db/tang"]

WORKDIR /app

EXPOSE 80

COPY app /app

RUN microdnf install -y \
        tang \
        socat &&\
    microdnf clean all &&\
    rm -rf /var/cache/yum

HEALTHCHECK --start-period=5s --timeout=3s CMD ["/app/check-tang.sh"]

CMD ["/app/start-tang.sh"]