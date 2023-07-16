label=Updater

function update {
    local src_dir=""
    src_dir="$(realpath "$(dirname "$(realpath "$0")")")" || return $?

    local old_updaters="$src_dir/updater.d"/*.sh

    cd "$src_dir" || return $?
    sudo git pull || return $?

    local new_updaters="$src_dir/updater.d"/*.sh

    if test "$old_updaters" != "$new_updaters"; then
        echo ""
        echo "Some updaters have changed. You may need to review your configuration."
    fi
}
