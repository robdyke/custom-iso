#!/bin/bash

set -e

mkdir -p /tmp/custom/squash
mkdir -p /tmp/custom/iso

mount -o loop /media/assets/original.iso /tmp/custom/iso

unsquashfs -f -d /tmp/custom/squash /tmp/custom/iso/casper/filesystem.squashfs

cp /media/assets/setup.sh /tmp/custom/squash/

systemd-nspawn --bind-ro=/etc/resolv.conf:/run/resolvconf/resolv.conf --setenv=RUNLEVEL=1 -D /tmp/custom/squash sh /setup.sh

# # rm /tmp/custom/newlive/var/lib/dbus/machine-id

# rsync -av --exclude casper/filesystem.squashfs /tmp/custom/iso/ /tmp/custom/newiso/

# mksquashfs /tmp/custom/newlive /tmp/custom/newiso/casper/filesystem.squashfs -noappend -b 1048576 -comp xz -Xdict-size 100%
# printf $(du -s --block-size=1 /tmp/custom/newlive | cut -f1) | tee /tmp/custom/newiso/casper/filesystem.size

# umount /tmp/custom/_squash /tmp/custom/newlive /tmp/custom/iso
