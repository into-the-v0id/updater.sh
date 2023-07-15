# Updater

Update your system with a single command

## About

This script calls various package managers in order to update your system.

Several package managers are supported. See [update.d](./update.d) for all available updaters.

## Installation

```console
# # Install updater source code
# mkdir -p /usr/local/share/updater/
# cd /usr/local/share/updater/
# git clone https://github.com/into-the-v0id/updater.sh.git .
# # Install updater executable
# chmod +x ./update.sh
# ln -s /usr/local/share/updater/update.sh /usr/local/bin/update
# # Install updater configuration
# mkdir -p /etc/updater.d/
# ln -s /usr/local/share/updater/update.d/*.sh /etc/updater.d/
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
--------
| Arch |
--------
:: Synchronizing package databases...
 core is up to date
 extra is up to date
warning: archlinux-keyring-20230704-1 is up to date -- skipping
 there is nothing to do
:: Starting full system upgrade...
 there is nothing to do
:: Looking for AUR upgrades...
:: Looking for devel upgrades...
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
