#!/bin/bash

# * This script initializes the Jenkins service on Fedora
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins