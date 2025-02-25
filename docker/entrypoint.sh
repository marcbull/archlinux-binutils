#!/bin/bash
set -eo pipefail

use_new_ld() {
    rm /usr/bin/ld
}

vcpkg_bootstrap() {
    local RELEASE="$1"

    if [ -d vcpkg ]; then
        pushd vcpkg
        git fetch
        popd
    else
        git clone https://github.com/microsoft/vcpkg.git
    fi

    pushd vcpkg
    git checkout ${RELEASE}
    popd

    ./vcpkg/bootstrap-vcpkg.sh -disableMetrics
}

vcpkg_install() {
    local CACHE_PATH=""
    CACHE_PATH="$(pwd)/vcpkg-cache"

    rm -rf ${CACHE_PATH}
    rm -rf vcpkg_installed
    ./vcpkg/vcpkg install --triplet x64-linux-dynamic --binarysource="clear;files,${CACHE_PATH},readwrite" --recurse
}

main() {
    local VCPGK_RELEASE="2025.01.13"

    if [ ! -z "$1" ]; then
        case $1 in
            ld-2.43)
                # Do nothing, as the latest version is already installed.
                ;;
            ld-2.44)
                use_new_ld
                ;;
            *)
                echo "Invalid argument: '$1'"
                exit 1
        esac
    else
        use_new_ld
    fi
    vcpkg_bootstrap ${VCPGK_RELEASE}
    vcpkg_install

    echo "Build completed successfully."
    echo "Execute: vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo"
}

main "$@"
