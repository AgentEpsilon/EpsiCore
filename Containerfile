FROM quay.io/fedora/fedora-bootc:42

RUN echo epsi > /etc/hostname
RUN ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime

# Cockpit
RUN dnf -y install cockpit-system cockpit-networkmanager cockpit-podman cockpit-selinux cockpit-machines cockpit-files

RUN dnf -y install fail2ban && systemctl enable fail2ban
COPY fail2ban/ /etc/fail2ban/

COPY units/ /usr/lib/systemd/system/

COPY containers/ /usr/share/containers/systemd/

COPY blocky.yml /etc/blocky.yml
COPY copyparty.conf /etc/copyparty.conf
COPY Caddyfile /etc/Caddyfile

COPY www/ /etc/www/

COPY homepage/ /etc/homepage/

# Enable auto-update of container images
RUN systemctl enable podman-auto-update.timer
