#!/bin/bash
set -eu

lb clean

if [ -z ${APT_PROXY} ]
then
	echo "No proxy specified"
	lb config
else
	echo "Using '${APT_PROXY}' for the apt proxy"
	lb config --apt-http-proxy "${APT_PROXY}"
fi

time lb build

mv *.iso /tmp/builds/
