#!/bin/bash

# Update packages database
# echo -e "$hr\nUPDATE PACKAGES\n$hr"
# apt update

# Setting default ruby version
echo -e "$hr\nRUBY_NODE VERSION\n$hr"
ruby -v
gem install bundler -v "${BUNDLER_VER}"
node -v && npm -v

# This is a temporary workaround
# See https://github.com/actions/checkout/issues/766
git config --global --add safe.directory "*"

# Generate a Gemfile.lock
# $ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app combos/ruby_node:3_16 bundle install
