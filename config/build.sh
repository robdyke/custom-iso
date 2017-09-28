#!/bin/bash
set -eu

lb clean
lb config
lb build

mv *.iso /tmp/builds/
