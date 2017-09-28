FROM debian:stretch-slim

RUN apt-get -yqq update && apt-get -yqq install \
  live-build \
  && rm -rf /var/lib/apt/lists/*

COPY config /tmp/builder

WORKDIR /tmp/builder
CMD ["sh", "./build.sh"]
