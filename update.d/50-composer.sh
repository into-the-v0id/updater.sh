label=Composer

function is_supported {
    which composer > /dev/null 2>&1 && composer global validate > /dev/null 2>&1
}

function update {
    composer global update
}
