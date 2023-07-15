label=Flatpak

function is_supported {
    which flatpak > /dev/null 2>&1
}

function update {
    flatpak update
}
