FROM ghcr.io/ublue-os/bluefin-dx:latest

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
#
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY build.sh /tmp/build.sh

# RUN curl -o /etc/yum.repos.d/fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo
#
# COPY --from=ghcr.io/ublue-os/akmods-extra:main-41 /rpms/ /tmp/rpms
#
# RUN find /tmp/rpms
#
# RUN rpm-ostree install /tmp/rpms/kmods/kmod-evdi*.rpm

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
