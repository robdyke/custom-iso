# Scripts to build a VirtualBox VDI drive image, and mount it in OSX

set -e

rm -f disk.*

if [ -n "$1" ]; then
    hdiutil create -srcfolder "$1" -fs FAT32 -volname LINUX -o ./disk
else
    hdiutil create -size 2g -fs FAT32 -volname LINUX -o ./disk
fi

VBoxManage convertfromraw disk.dmg disk.vdi --variant Fixed
rm disk.dmg
ln -s disk.vdi disk.img
hdiutil attach -section 0x1000 disk.img
