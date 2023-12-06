# diskman

**diskman** is an interactive command-line interface for safely managing removable disks.

It can be seen as a wrapper around `dd`, `fdisk`, and `mkfs.*`.

These tools are all perfectly suitable for managing removable disks, and `diskman` does **not** attempt to wrap their interfaces. Instead, its purpose is simply to prevent you from accidentally picking the wrong disk. It should not sit well with anyone that the only difference between wiping a pen drive and a (SATA) system disk is the _single character_ at the end of `/dev/sd`.

`diskman` lets you _only_ pick from removable disks, and confirms before executing any destructive commands.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/diskman).

```
gem install diskman
```

The binary is called `diskman`.

## Usage

```
Usage:
    diskman write <file>
    diskman fdisk
    diskman mkfs [ --list ]
    diskman ( --version | --help )

Options:
    -v, --version  Show version
    -h, --help     Show help
```

## Examples

### `write`

Writes an image to the device.

In this example there is only one device so it has been auto-selected.

```
$ diskman write archlinux-2019.10.01-x86_64.iso

Found the following removable device.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]

Press enter to select it.

File:    archlinux-2019.10.01-x86_64.iso (657M)
Device:  /dev/sde [61G, SanDisk Ultra USB 3.0]
Command: dd if="archlinux-2019.10.01-x86_64.iso" of="/dev/sde" bs=4M status=progress conv=fsync

Are you sure? Type "yes".

> yes

160511+2 records in
160511+2 records out
657457152 bytes (657 MB, 627 MiB) copied, 43.6238 s, 15.1 MB/s
```

### `clone`

Clones a device to an image file.

```
$ diskman clone disk.img

Found the following removable device.

    1. /dev/sdd [61G, SanDisk Ultra USB 3.0]

Press enter to select it.

File:    disk.img
Device:  /dev/sdd [61G, SanDisk Ultra USB 3.0]
Command: sudo dd if="/dev/sdd" of="disk.img" bs=4M status=progress conv=fsync

Are you sure? Type "yes"

> yes

15226+1 records in
15226+1 records out
63864569856 bytes (64 GB, 59 GiB) copied, 802.035 s, 79.6 MB/s
```

### `mkfs`

Formats a device as a particular filesystem.

In this example (and the one following) there are two devices so the user has to pick one.

```
$ diskman mkfs

Choose from the following removable devices.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]
    2. /dev/sdf [2G, USB 2.0 USB Flash Drive]

Enter your selection.

> 1

Choose from the following devices.

    1. /dev/sde
    2. /dev/sde1
    3. /dev/sde2

Enter your selection.

> 2

Choose from the following filesystems.

    1. bfs
    2. btrfs
    3. cramfs
    4. exfat
    5. ext2
    6. ext3
    7. ext4
    8. fat
    9. minix
   10. msdos
   11. vfat
   12. xfs

Enter your selection.

> 6

Filesystem: ext3
Device:     /dev/sde1
Command:    sudo mkfs.ext3 /dev/sde1

Are you sure? Type "yes".

> yes

mke2fs 1.45.4 (23-Sep-2019)
/dev/sde1 contains a iso9660 file system labelled 'CD'
Proceed anyway? (y,N) y
Creating filesystem with 160512 4k blocks and 40160 inodes
Filesystem UUID: 24b617af-43fe-4502-b554-9ba913795c61
Superblock backups stored on blocks:
        32768, 98304

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done
```

### `fdisk`

Starts fdisk for the device.

```
$ diskman fdisk

Choose from the following removable devices.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]
    2. /dev/sdf [2G, USB 2.0 USB Flash Drive]

Enter your selection.

> 1

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x2736460c.

Command (m for help):
```

## Contributions

Open an [issue](https://github.com/crdx/diskman/issues) or send a [pull request](https://github.com/crdx/diskman/pulls).

## Licence

[GPLv3](LICENCE).
