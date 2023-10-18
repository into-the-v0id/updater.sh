label=Rustup

function is_supported {
    which rustup > /dev/null 2>&1
}

function update {
    rustup update
}
