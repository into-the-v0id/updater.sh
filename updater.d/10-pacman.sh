label=Pacman

function is_supported {
    which pacman > /dev/null 2>&1
}

function update {
    pacman -Sy && pacman -S --needed archlinux-keyring && pacman -Su
}
