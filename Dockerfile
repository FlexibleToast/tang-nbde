FROM registry.fedoraproject.org/fedora-minimal:latest

ENV ENABLE_IPv4=1
ENv ENABLE_IPv6=0

VOLUME /db
WORKDIR /app

EXPOSE 80

COPY app /app

RUN microdnf install -y \
        tang \
        socat &&\
    microdnf clean all &&\
    rm -rf /var/cache/yum

CMD "/app/start-tang.sh"

HEALTHCHECK --start-period=5s --timeout=3s \
    CMD "/app/check-tang.sh"