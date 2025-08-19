#!/usr/bin/env bash
set -e  # exit on error

# Update system packages
sudo apt update -y

# Install ansible & pip3
sudo apt install -y ansible python3-pip

# Install python dependencies globally
sudo pip3 install boto3 botocore
