label=Paru

function is_supported {
    which paru > /dev/null 2>&1
}

function update {
    paru --aur -Syu
}
