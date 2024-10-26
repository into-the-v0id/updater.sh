label="Self Updater"

function update {
    local src_dir=""
    src_dir="$(realpath "$(dirname "$(realpath "$0")")")" || return $?

    local old_updaters=("$src_dir/updater.d"/*.sh)

    local src_owner=""
    src_owner="$(find "$src_dir" -maxdepth 0 -type d -printf "%U")" || return $?
    if test "$src_owner" == "$(id -u)"; then
        git -C "$src_dir" pull || return $?
    else
        sudo git -C "$src_dir" pull || return $?
    fi

    local new_updaters=("$src_dir/updater.d"/*.sh)

    if test "${old_updaters[*]}" != "${new_updaters[*]}"; then
        echo ""
        echo "Some updaters have changed. You may need to update your configuration:"
        echo ""
        echo "    sudo ln -sv \"$src_dir/updater.d\"/* /etc/updater.d/ # add new updaters"
        echo "    sudo find /etc/updater.d/ -xtype l -print -delete # remove old updaters"
    fi
}
