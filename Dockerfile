FROM registry.fedoraproject.org/fedora-minimal:latest

ENV ENABLE_IPv4=1
ENv ENABLE_IPv6=0

VOLUME /db

EXPOSE 80

COPY check-tang.sh start-tang.sh /usr/local/sbin

RUN microdnf install -y \
        tang \
        socat &&\
    microdnf clean all &&\
    rm -rf /var/cache/yum

CMD "start-tang"

HEALTHCHECK --start-period=5s --timeout=3s \
    CMD "check-tang"