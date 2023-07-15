#!/usr/bin/env bash

set -e
set -o pipefail

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

    test "$is_first_headline" == "1" && is_first_headline="0" || echo ""

    local label="$1"

    echo "--$(echo "$label" | sed "s/./-/g")--"
    echo "| $label |"
    echo "--$(echo "$label" | sed "s/./-/g")--"
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

    local script_filepath="$1"
    local script_filename="$(basename "$script_filepath")"

    unset label
    unset -f is_supported
    unset -f update

    source "$script_filepath"

    if test "$(type -t is_supported)" == "function" && ! is_supported; then
        return 0
    fi

    label="${label:-$script_filename}"
    print_headline "$label"

    if ! test "$(type -t update)" == "function"; then
        echo "[warning] Invalid updater: $script_filepath does not define an update function" 1>&2
        return 0
    fi

    update
}

function main {
    if test "$#" != "0"; then
        echo "Unexpected arguments" 1>&2
        return 2
    fi

    local script_dirs=("/etc/update.d" "${XDG_CONFIG_HOME:-$HOME/.config}/update.d")

    for script_dir in "${script_dirs[@]}"; do
        if ! test -d "$script_dir"; then
            continue
        fi

        for script_file in "$script_dir"/*.sh; do
            run_updater "$script_file" || return $?
        done
    done

    return 0
}

main $@

exit $?
