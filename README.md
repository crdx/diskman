# diskman

`diskman` is a command-line interface for safely managing removable disks.

In its most general sense it can be seen as a wrapper around `dd`, `fdisk`, and `mkfs.*`.

These tools are all perfectly suitable for managing removable disks, and this tool does **not** attempt to wrap their interfaces. Instead, the purpose of `diskman` is simply to prevent you from accidentally picking the wrong disk. It should not sit well with anyone that the only difference between wiping a pen drive and a system disk is the _single character_ at the end of `/dev/sd`.

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

### Examples

### `write`

### `mkfs`

## Tests

Run tests with `tools/test`.

<!-- Code coverage stands at roughly 95% for library code. -->

## Fixes or contributions

Open an [issue](http://github.com/crdx/diskman/issues) or send a [pull request](http://github.com/crdx/diskman/pulls).

## Licence

[MIT](LICENCE.md).
