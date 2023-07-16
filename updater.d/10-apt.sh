label=APT

function is_supported {
    which apt > /dev/null 2>&1
}

function update {
    sudo apt update && sudo apt upgrade
}
