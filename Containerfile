FROM quay.io/fedora/fedora-bootc:42

# Cockpit
RUN dnf install cockpit-system cockpit-networkmanager cockpit-podman cockpit-selinux cockpit-machines

COPY jellyfin.container /usr/share/containers/systemd/jellyfin.container
COPY cockpit.container /usr/share/containers/systemd/cockpit.container

# Enable auto-update of container images
RUN systemctl enable podman-auto-update.service