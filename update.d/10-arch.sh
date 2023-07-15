label=Arch

function is_supported {
    which paru > /dev/null 2>&1 \
        || which yay > /dev/null 2>&1 \
        || which pacman > /dev/null 2>&1
}

function update {
    if which paru > /dev/null 2>&1; then
        paru -Sy && paru -S --needed archlinux-keyring && paru -Su
    elif which yay > /dev/null 2>&1; then
        yay -Sy && yay -S --needed archlinux-keyring && yay -Su
    elif which pacman > /dev/null 2>&1; then
        pacman -Sy && pacman -S --needed archlinux-keyring && pacman -Su
    fi
}
