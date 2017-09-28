FROM debian:stretch-slim

RUN apt-get -yqq update && apt-get -yqq install \
  live-build \
  && rm -rf /var/lib/apt/lists/*

ADD config /opt/live
WORKDIR /opt/live

RUN chmod -R +x auto/

CMD ["sh", "./build.sh"]
