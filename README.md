# diskman

`diskman` is an interactive command-line interface for safely managing removable disks.

In its most general sense it can be seen as a wrapper around `dd`, `fdisk`, and `mkfs.*`.

These tools are all perfectly suitable for managing removable disks, and `diskman` does **not** attempt to wrap their interfaces. Instead, its purpose is simply to prevent you from accidentally picking the wrong disk. It should not sit well with anyone that the only difference between wiping a pen drive and a system disk is the _single character_ at the end of `/dev/sd`.

`diskman` lets you pick from _only_ removable disks, and confirms before executing any destructive commands.

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
    -h, --help     Show this help
```

## Examples

### `write`

Writes an image to the device.

```
$ diskman write ~/iso/archlinux-2019.10.01-x86_64.iso

Found the following removable device.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]

Press any key to select it.

File:    ~/iso/archlinux-2019.10.01-x86_64.iso (657M)
Device:  /dev/sde [61G, SanDisk Ultra USB 3.0]
Command: dd if="~/iso/archlinux-2019.10.01-x86_64.iso" | pv --size 657457152 | sudo dd of="/dev/sde" bs=4096

Are you sure? Type "YES" if so.

> YES

627MiB 0:00:36 [17.3MiB/s] [============================>] 100%
160511+2 records in
160511+2 records out
657457152 bytes (657 MB, 627 MiB) copied, 43.6238 s, 15.1 MB/s
```

### `mkfs`

Formats a device as a particular filesystem.

```
$ diskman mkfs

Please pick from the following removable devices.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]
    2. /dev/sdf [2G, USB 2.0 USB Flash Drive]

Enter the number of your selection.

> 1

Please pick from the following devices.

    1. /dev/sde
    2. /dev/sde1
    3. /dev/sde2

Enter the number of your selection.

> 2

Please pick from the following filesystems.

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

Enter the number of your selection.

> 6

Filesystem: ext3
Device:     /dev/sde1
Command:    sudo mkfs.ext3 /dev/sde1

Are you sure? Type "YES" if so.

> YES

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
### fdisk


Starts fdisk for the device.

```
$ diskman fdisk

Please pick from the following removable devices.

    1. /dev/sde [61G, SanDisk Ultra USB 3.0]
    2. /dev/sdf [2G, USB 2.0 USB Flash Drive]

Enter the number of your selection.

> 1

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x2736460c.

Command (m for help):
```

## Fixes or contributions

Open an [issue](http://github.com/crdx/diskman/issues) or send a [pull request](http://github.com/crdx/diskman/pulls).

## Licence

[MIT](LICENCE.md).
