#!/bin/bash

# * This script initializes the Docker service on Fedora

# Enable the Docker service
systemctl enable docker

# Start the Docker service
systemctl start docker
