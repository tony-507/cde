#!/bin/bash

echo "Installing necessary packages..."

yum update -y

# RPM tools
yum install -y rpmdevtools
yum install -y rpm-build

# Build tools
yum install -y golang
