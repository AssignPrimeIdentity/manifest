#!/bin/bash

# Update packages database
echo -e "$hr\nUPDATE PACKAGES\n$hr"
apt install sudo
usermod -aG sudo root
sudo apt update

# Setting default ruby version
echo -e "$hr\nDEFAULT VERSION\n$hr"
ruby -v && bundle version

# This is a temporary workaround
# See https://github.com/actions/checkout/issues/766
git config --global --add safe.directory "*"
