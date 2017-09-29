FROM ubuntu:xenial

RUN apt-get -yqq update && apt-get -yqq install \
  isolinux \
  live-build \
  syslinux \
  syslinux-common \
  time \
  xorriso \
  && rm -rf /var/lib/apt/lists/*

ADD config /opt/live
WORKDIR /opt/live

RUN chmod -R +x auto/
VOLUME ["/opt/live"]

CMD ["sh", "./build.sh"]
