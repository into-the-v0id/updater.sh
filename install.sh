#!/usr/bin/env bash

set -e
set -u
set -o pipefail

src_dir="/usr/local/share/updater"
bin_dir="/usr/local/bin"
config_dir="/etc/updater.d"

echo "=> Downloading source code"
mkdir -pv "$src_dir"
if test -n "$(ls -A "$src_dir")" ; then
    echo "[error] Updater is already installed" 1>&2
    exit 1
fi
git clone "https://github.com/into-the-v0id/updater.sh.git" "$src_dir"

echo ""
echo "=> Installing executable"
if ! test -d "$bin_dir"; then
    echo "[error] Directory $bin_dir does not exist" 1>&2
    exit 1
fi
chmod -v +x "$src_dir/update.sh"
ln -sv "$src_dir/update.sh" "$bin_dir/update"
if ! (echo ":$PATH:" | grep -F ":$bin_dir:" > /dev/null 2>&1); then
    echo "[warning] Directory $bin_dir does not seem to be in your \$PATH. Add $bin_dir to your \$PATH in order to be able to execute the updater" 1>&2
fi

echo ""
echo "=> Installing configuration"
mkdir -pv "$config_dir"
ln -sv "$src_dir/updater.d"/*.sh "$config_dir"

echo ""
echo "=> Successfully installed"
