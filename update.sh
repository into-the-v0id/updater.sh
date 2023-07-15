#!/usr/bin/env bash

# Copyright (C) Oliver Amann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
set -o pipefail

IFS=$'\n'

is_first_headline="1"
function print_headline {
    if test "$#" == "0"; then
        echo "Missing headline label" 1>&2
        return 2
    fi

    if test "$#" -gt "1"; then
        echo "Too many arguments" 1>&2
        return 2
    fi

    local label="$1"

    if test "$is_first_headline" == "0"; then
        echo ""
    fi

    echo "--$(echo "$label" | sed "s/./-/g")--"
    echo "| $label |"
    echo "--$(echo "$label" | sed "s/./-/g")--"

    is_first_headline="0"
}

function run_updater {
    if test "$#" == "0"; then
        echo "Missing script path" 1>&2
        return 2
    fi

    if test "$#" -gt "1"; then
        echo "Too many arguments" 1>&2
        return 2
    fi

    local script_path="$1"
    local script_filename="$(basename "$script_path")"

    unset label
    unset -f is_supported
    unset -f update

    source "$script_path"

    if test "$(type -t is_supported)" == "function" && ! is_supported; then
        return 0
    fi

    label="${label:-$script_filename}"
    print_headline "$label"

    if ! test "$(type -t update)" == "function"; then
        echo "[warning] Invalid updater: $script_path does not define an update function" 1>&2
        return 0
    fi

    update
}

function find_updaters {
    if test "$#" == "0"; then
        echo "Missing script dirs" 1>&2
        return 2
    fi

    local script_dirs=("$@")

    local script_filenames=()
    for script_dir in "${script_dirs[@]}"; do
        if ! test -d "$script_dir"; then
            continue
        fi

        for script_path in "$script_dir"/*.sh; do
            script_filenames+=("$(basename "$script_path")")
        done
    done

    local script_filenames_final=()
    while read -r script_filename; do
        script_filenames_final+=("$script_filename")
    done <<< "$(printf "%s\n" "${script_filenames[@]}" | sort -n | uniq)"

    local script_paths=()
    for script_filename in "${script_filenames_final[@]}"; do
        local script_path=""
        for script_dir in "${script_dirs[@]}"; do
            if test -f "$script_dir/$script_filename"; then
                script_path="$script_dir/$script_filename"
                break
            fi
        done

        if test -z "$script_path"; then
            echo "Unable to find updater $script_filename" 1>&2
            return 0
        fi

        script_paths+=("$script_path")
    done

    echo "${script_paths[*]}"
}

function main {
    if test "$#" != "0"; then
        echo "Unexpected arguments" 1>&2
        return 2
    fi

    local script_paths="$(find_updaters "${XDG_CONFIG_HOME:-$HOME/.config}/updater.d" "/etc/updater.d")"
    for script_path in $script_paths; do
        run_updater "$script_path" || return $?
    done

    return 0
}

main $@

exit $?
