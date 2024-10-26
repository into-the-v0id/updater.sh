label="Yay Self Updater"

function is_supported {
    which yay > /dev/null 2>&1
}

function update {
    yay -Qsq "\\byay\\b" | xargs yay -S --needed
}
