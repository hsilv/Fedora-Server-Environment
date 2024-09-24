#!/bin/bash

# * This script install Jenkins on Fedora

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf -y upgrade
# Add required dependencies for the jenkins package
sudo dnf install -y fontconfig java-17-openjdk
sudo dnf install -y jenkins