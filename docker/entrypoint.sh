#!/bin/bash
set -eo pipefail

downgrade() {
    curl -L https://archive.archlinux.org/packages/b/binutils/binutils-2.43_1%2Br186%2Bg61f8adadd6db-1-x86_64.pkg.tar.zst -o /tmp/binutils.pkg.tar.zst
    pacman -U --noconfirm /tmp/binutils.pkg.tar.zst
    rm -rf /tmp/binutils.pkg.tar.zst
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
            upgrade)
                # Do nothing, as the latest version is already installed.
                ;;
            downgrade)
                downgrade
                ;;
            *)
                echo "Invalid argument: '$1'"
                exit 1
        esac
    fi
    vcpkg_bootstrap ${VCPGK_RELEASE}
    vcpkg_install

    echo "Build completed successfully."
    echo "Execute: vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo"
}

main "$@"
