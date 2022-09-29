#!/bin/sh -e

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R $PUID:$GUID /db
fi

TANG="system:'REMOTE_ADDR=\$SOCAT_PEERADDR tangd /db'"

if [ "$ENABLE_IPv4" = "1" ]; then
  socat TCP4-LISTEN:80,reuseaddr,fork "$TANG" &
fi

if [ "$ENABLE_IPv6" = "1" ]; then
  socat TCP6-LISTEN:80,ipv6only=1,reuseaddr,fork "$TANG" &
fi

wait