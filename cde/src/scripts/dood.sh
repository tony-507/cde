#!/bin/bash

# Install Docker for development and CI/CD workflow
echo "Installing Docker CLI..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce-cli
