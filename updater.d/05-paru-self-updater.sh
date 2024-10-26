label="Paru Self Updater"

function is_supported {
    which paru > /dev/null 2>&1
}

function update {
    paru -Qsq "\\bparu\\b" | xargs paru -S --needed
}
