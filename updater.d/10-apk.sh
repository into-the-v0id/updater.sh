label=APK

function is_supported {
    which apk > /dev/null 2>&1
}

function update {
    sudo apk update && sudo apk upgrade
}
