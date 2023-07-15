# Updater

Update your system with a single command

## About

This script calls various package managers in order to update your system.

Several package managers are supported. See [updater.d](./updater.d) for all available updaters.

## Installation

```console
$ curl -sSf "https://raw.githubusercontent.com/into-the-v0id/updater.sh/main/install.sh" | sudo bash
```

## Usage

```console
$ update
```

## Configuration

Updaters can be defined in `/etc/updater.d/` and `~/.config/updater.d/`. You may use the built-in updaters or write your own.

### Disable a built-in updater

Remove the symlink in `/etc/updater.d/` for the updater.

## Example

```console
$ update
-----------
| Updater |
-----------
Already up to date.

----------
| Pacman |
----------
:: Synchronizing package databases...
 core is up to date
 extra is up to date
warning: archlinux-keyring-20230704-1 is up to date -- skipping
 there is nothing to do
:: Starting full system upgrade...
 there is nothing to do

-----------
| Flatpak |
-----------
Looking for updates…

Nothing to do.

------------
| Firmware |
------------
Updating lvfs
Downloading…             [                                       ]
Successfully downloaded new metadata: 1 local device supported
Devices with no available firmware updates: 
 • Integrated Webcam HD
 • UEFI Device Firmware
 • UEFI Device Firmware
Devices with the latest available firmware version:
 • System Firmware
```

## License

Copyright (C) Oliver Amann

This project is licensed under the GNU General Public License Version 3 (GPL-3.0-only). Please see [LICENSE](./LICENSE) for more information.
