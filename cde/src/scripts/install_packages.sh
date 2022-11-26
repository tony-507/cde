#!/bin/bash

echo "Installing necessary packages..."

yum update -y

yum install -y yum-utils

# RPM tools
yum install -y rpmdevtools
yum install -y rpm-build

# Golang
yum install -y golang

# Ansible
# This cannot be installed via EPEL due to conflict with yum
python3 /opt/tony57/tmp/get-pip.py
pip install ansible
