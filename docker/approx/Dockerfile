FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/00InstallRecommends && \
    echo '9999 stream tcp nowait approx /usr/sbin/approx approx' > /etc/inetd.conf && \
    apt-get -yqq update && apt-get install -yqq \
    approx \
    openbsd-inetd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY approx.conf /etc/approx/approx.conf

VOLUME /var/cache/approx
EXPOSE 9999
CMD ["inetd", "-i"]
