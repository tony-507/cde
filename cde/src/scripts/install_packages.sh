#!/bin/bash

install () {
	yum install -y -q $1
}

echo "Installing necessary packages..."

yum update -y -q

install yum-utils

# RPM tools
install rpmdevtools

# Nodejs
echo "Installing Nodejs..."
install nodejs

# Java development kit
echo "Installing Java..."
install java-11-openjdk-devel
install java-11-openjdk
curl -o /opt/tony57/tmp/jdk-17_linux-x64_bin.rpm https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
yum localinstall -y -q /opt/tony57/tmp/jdk-17_linux-x64_bin.rpm
echo "Adding Java environment variable..."
echo "export JAVA_HOME=\"$(which java)\"" >> $HOME/.bashrc

# Pip
echo "Installing pip..."
python3 /opt/tony57/tmp/get-pip.py
