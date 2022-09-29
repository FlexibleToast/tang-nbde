#!/bin/bash

set -e

mkdir -p /var/db/tang /var/cache/tang

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R ${PUID}:${GUID} /var/db/tang
fi

socat tcp-l:80,reuseaddr,fork exec:"/usr/libexec/tangd /var/cache/tang"