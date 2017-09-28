FROM debian:stretch-slim

RUN apt-get -yqq update && apt-get -yqq install \
  apt-utils \
  live-build \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/builder
