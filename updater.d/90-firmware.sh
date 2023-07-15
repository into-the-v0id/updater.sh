label=Firmware

function is_supported {
    which fwupdmgr > /dev/null 2>&1
}

function update {
    fwupdmgr refresh --force && fwupdmgr update
}
