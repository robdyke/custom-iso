#!/bin/bash

set -e -u

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install -y docker-ce make

usermod -a -G docker ubuntu

curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

cat > /usr/local/bin/bootstrap-iso-builder <<- EOM
git clone https://github.com/atkinchris/custom-iso.git
cd custom-iso
chmod +x ./run.sh
EOM
chmod +x /usr/local/bin/bootstrap-iso-builder
