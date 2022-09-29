#!/bin/bash

set -e

mkdir -p /var/db/tang /var/cache/tang

socat tcp-l:80,reuseaddr,fork exec:"/usr/libexec/tangd /var/cache/tang"