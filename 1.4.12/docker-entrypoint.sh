#!/bin/bash
set -e

if [ $# -eq 0 ]; then
    exec supervisord -c /usr/etc/supervisord.conf --nodaemon
else
    supervisord -c /usr/etc/supervisord.conf
    exec "$@"
fi
