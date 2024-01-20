#!/bin/sh

sudo podman build -t ghcr.io/gbraad-fedora/bootc-test -f ./Containerfile
sudo podman push ghcr.io/gbraad-fedora/bootc-test
sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/config.json:/config.json \
    -v $(pwd)/output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type qcow2 \
    --config /config.json \
    ghcr.io/gbraad-fedora/bootc-test:latest
