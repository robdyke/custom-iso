FROM debian:stretch

RUN apt-get -qy update && apt-get install -qy \
    live-build \
    time

COPY config /var/livecd
WORKDIR /var/livecd

RUN chmod -R +x auto/ && \
    chmod -R +x config/hooks && \
    chmod +x ./build.sh

VOLUME ["/tmp/builds", "/tmp/logs", "/tmp/cache"]

ENTRYPOINT ["time", "./build.sh"]
