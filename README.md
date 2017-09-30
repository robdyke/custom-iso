# Custom Ubuntu Mastering


## File Information

For EFI boot, only the following files are needed. These can be placed on the root of a FAT formatted USB stick - no special partitions are required.

```
├── EFI
│   └── BOOT
│       ├── BOOTx64.EFI
│       ├── grub.cfg
│       └── grubx64.efi
└── casper
    ├── filesystem.squashfs
    ├── initrd.lz
    └── vmlinuz.efi
```

`EFI` contains the `BOOTx64.EFI` that will be searched for and run by most 64bit EFI systems. That loads the EFI version of Grub2, `grubx64.efi`. The Grub config is then loaded from the `grub.cfg` located alongside Grub (this behaviour _may_ be non-standard. The Grub config can also live in `/boot/grub/grub.cfg`).

`casper` contains the Linux kernel (`vmlinuz.efi`), the initial file system (`initrd.lz`) and the squashed filesystem (`filesystem.squashfs`) for our live environment. Grub mounts the initial file system, and runs the kernel with the options from the menu entry in `grub.cfg`. In most setups, this will use `boot=casper` to use [casper](http://manpages.ubuntu.com/manpages/zesty/man7/casper.7.html) to bring up the system from the squashed filesystem.

Persistence files and snapshots would also be placed into the `/casper` folder (and the Grub menu entry updated as needed).

**Note**: on the standard live CD ISO there are _many_ other files. These are mostly to support the other functions of the LiveCD, such as installation and repair, and to allow the system to be booted from a CD or on a non-EFI system. As we are specifically concerned with live booting using EFI from a FAT USB device, we can discard all these other files.


## Mounting VDI images in OSX

Create VDI, and format to FAT via LiveCD/etc. Information mostly from [unfinishedbitness](https://unfinishedbitness.info/2017/02/06/mac-os-x-native-vdi-image-mounts).

```
# Symbolic link as hdiutil doesn't like vdi extension
ln -s disk.vdi disk.img
hdiutil attach -agent hdid -section 0x1000 -readonly disk.img
```


## Editing the Live environment

There are two main ways to edit the live environment.


### Editing the filesystem

You can edit the `filesystem.squashfs`, by extracting it and using chroot (or equivalent), to remove/add packages, edit files/config and almost anything else. The filesystem is then squashed down, and replaces the original in the `/casper` directory.

This produces a single filesystem, and requires little tampering - once squashed, the system is ready to boot.


### Persistence

Casper can support adding a persistence layer to the read only file system, allowing it to persist overlay changes to a file or partition. It should be possible to boot the live CD with persistence, make any changes required, then save the persistence to a file. (Alternatively, you could mount as normal, without persistence and use `casper-snapshot` to capture changes).

With a modified script within `initrd.lz`, it is possible to mount this persistence or snapshot file as read only, on top of the filesystem.

This is good, as it allows the base file system to remain untouched, for signature checks - or even swapping out for other live CD file systems (to bring changes between distros).
