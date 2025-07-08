FROM quay.io/fedora/fedora-bootc:42

RUN echo "epsicore" > /etc/hostname

# Cockpit
RUN dnf -y install cockpit-system cockpit-networkmanager cockpit-podman cockpit-selinux cockpit-machines cockpit-files

COPY jellyfin.container /home/jellyfin/.config/containers/systemd/jellyfin.container
COPY cockpit.container /usr/share/containers/systemd/cockpit.container
COPY technitium-dns.container /usr/share/containers/systemd/technitium-dns.container

# Disable systemd-resolved in favor of technitium
RUN systemctl disable systemd-resolved
COPY resolv.conf /etc/resolv.conf

# Enable auto-update of container images
RUN systemctl enable podman-auto-update.service

# linger Jellyfin user
RUN mkdir -p /var/lib/systemd/linger && touch /var/lib/systemd/linger/jellyfin
