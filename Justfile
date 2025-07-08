set shell := ["powershell.exe", "-c"]

build-container:
    podman build -t epsicore-bootc .

build-image:
    podman run --rm -it --privileged --pull=newer --security-opt label=type:unconfined_t \
        -v ./output:/output \
        -v /var/lib/containers/storage:/var/lib/containers/storage \
        -v ./config.json:/config.json:ro \
        quay.io/centos-bootc/bootc-image-builder:latest \
        --type qcow2 --rootfs btrfs --use-librepo=true \
        localhost/epsicore-bootc:latest

qemu:
    qemu-system-x86_64.exe -smp 2 -m 4096 -snapshot .\output\qcow2\disk.qcow2 -nic tap,ifname="OpenVPN TAP-Windows6"

build: build-container build-image

dev: build qemu