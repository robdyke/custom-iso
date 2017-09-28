FROM debian:stretch

RUN apt-get -yqq update && apt-get -yqq install \
  live-build \
  debootstrap \
  apt-utils \
  sudo \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd builder
RUN useradd -m -g builder -G sudo -s /bin/bash builder
RUN echo 'builder ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/builder
RUN chmod 440 /etc/sudoers.d/builder

WORKDIR /home/builder
USER builder
