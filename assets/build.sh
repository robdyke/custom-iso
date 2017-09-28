#!/bin/bash
set -eu

# export http_proxy=$DEBIAN_MIRROR

lb config # --apt-http-proxy=$DEBIAN_MIRROR
lb build

mv *.iso /tmp/builds/
