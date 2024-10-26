label=Yay

function is_supported {
    which yay > /dev/null 2>&1
}

function update {
    yay -Syu
}
