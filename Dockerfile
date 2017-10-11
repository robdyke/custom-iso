FROM debian:stretch

RUN apt-get -qy update && apt-get install -qy \
    live-build \
    time \
    grub-efi-amd64-bin

COPY config /var/livecd
WORKDIR /var/livecd

RUN chmod -R +x auto/ && \
    chmod -R +x config/hooks && \
    chmod +x ./build.sh

VOLUME ["/tmp/builds", "/tmp/logs"]

ENTRYPOINT ["time", "./build.sh"]
