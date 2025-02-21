#!/bin/bash
set -eo pipefail

main() {
    local IMAGE_NAME="archlinux-binutils-test"
    local MOUNT_DIR=""
    MOUNT_DIR="$(dirname "$(pwd)")"

    echo "Building Docker image..."
    docker build --no-cache -t ${IMAGE_NAME} -f docker/Dockerfile docker

    docker run -it --rm -v ${MOUNT_DIR}:${MOUNT_DIR} --workdir "$(pwd)" ${IMAGE_NAME} "$1"
}

main "$@"
