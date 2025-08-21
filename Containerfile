FROM quay.io/fedora/fedora-bootc:42

RUN echo epsi > /etc/hostname
RUN ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime

# Cockpit
RUN dnf -y install cockpit-system cockpit-networkmanager cockpit-podman cockpit-selinux cockpit-machines cockpit-files

COPY var-mnt-ssd.mount /usr/lib/systemd/system/var-mnt-ssd.mount

COPY containers/ /usr/share/containers/systemd/

# Disable systemd-resolved in favor of technitium
RUN systemctl disable systemd-resolved
COPY resolv.conf /etc/resolv.conf

COPY blocky.yml /etc/blocky.yml
COPY copyparty.conf /etc/copyparty.conf

# Enable auto-update of container images
RUN systemctl enable podman-auto-update.timer

# linger Jellyfin user
RUN mkdir -p /var/lib/systemd/linger && touch /var/lib/systemd/linger/jellyfin
