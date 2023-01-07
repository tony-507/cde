#!/bin/bash

# Miscellaneous tools
yum install -y -q bc # Arithmetics

# Golang
echo "Installing Go..."
yum install -y -q golang

# Ansible
# This cannot be installed via EPEL due to conflict with yum
echo "Installing Ansible..."
pip install ansible --quiet

# CMake
echo "Installing cmake..."
yum install -y -q cmake
