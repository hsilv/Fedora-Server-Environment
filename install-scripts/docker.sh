#!/bin/bash

# This script installs Docker on Fedora

# Install Docker on Fedora
dnf -y update
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io
dnf -y install docker-compose
dnf -y install systemd
dnf clean all

# Configure Docker to start on boot
if [ ! -d "/run/systemd" ]; then
    mkdir -p /run/systemd
    echo 'docker' > /run/systemd/container
fi