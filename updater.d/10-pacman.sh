label=Pacman

function is_supported {
    which pacman > /dev/null 2>&1
}

function update {
    sudo pacman -Sy && sudo pacman -S --needed archlinux-keyring && sudo pacman -Su
}
