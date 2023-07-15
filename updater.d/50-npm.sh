label=NPM

function is_supported {
    which npm > /dev/null 2>&1
}

function update {
    sudo npm update --global
}
