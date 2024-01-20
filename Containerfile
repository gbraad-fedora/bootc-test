FROM quay.io/centos-bootc/fedora-bootc:eln

# install tailscale
RUN dnf install -y \
        dnf-plugins-core \
        systemd \
    && dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
    && dnf install -y \
        tailscale \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && sed -i 's/FLAGS=""/FLAGS="--tun=userspace-networking"/g' /etc/default/tailscaled \
    && systemctl enable tailscaled

ENTRYPOINT ["/sbin/init"]
