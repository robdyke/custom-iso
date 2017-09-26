#!/bin/bash

set -e

ISO=${1}

7z x $ISO -oextracted
rsync -av --files-from=files.lst extracted output

rm -rf extracted
