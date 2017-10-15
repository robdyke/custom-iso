#!/bin/bash

# squid entrypoint
if [ "$1" = 'squid' ]; then
    chown -R proxy.proxy /cache
    chown proxy.proxy /dev/stdout

    . /usr/share/squid-deb-proxy/init-common.sh
    pre_start
    post_start

    exec /usr/sbin/squid3 -N
fi

exec "$@"
