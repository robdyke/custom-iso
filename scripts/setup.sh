#!/bin/bash

set -e

# Install apps

apt-get update

# VS Code

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Node

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Update and install packages

apt-get update
apt-get -y install build-essential zsh git-core code nodejs yarn


# Clean up

apt-get autoremove --purge
apt-get clean
