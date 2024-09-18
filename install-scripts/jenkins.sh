#!/bin/bash

# This script installs Jenkins on Fedora

# Install Jenkins on Fedora
dnf -y update
dnf -y install java-11-openjdk
dnf -y install wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
dnf -y install jenkins

# Start Jenkins
systemctl enable jenkins