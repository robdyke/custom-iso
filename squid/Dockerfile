FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qy update && apt-get install -qy \
    squid-deb-proxy \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Redirect cache folder and squid logs
RUN ln -sf /cache /var/cache/squid-deb-proxy && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/access.log && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/store.log && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/cache.log

ADD entrypoint.sh /entrypoint.sh

VOLUME /cache
EXPOSE 8000
EXPOSE 5353/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["squid"]
