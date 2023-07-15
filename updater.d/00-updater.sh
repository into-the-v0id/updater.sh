label=Updater

function update {
    local src_dir="$(realpath "$(dirname "$(realpath "$0")")")"

    local old_updaters="$(ls -Al "$src_dir/updater.d")"
    cd "$src_dir"
    sudo git pull
    local new_updaters="$(ls -Al "$src_dir/updater.d")"

    if test "$old_updaters" != "$new_updaters"; then
        echo ""
        echo "Some updaters have changed. You may need to review your configuration."
    fi
}
