#!/bin/bash

# Update packages database
# echo -e "$hr\nUPDATE PACKAGES\n$hr"
# apt update
# gem install bundler -v "${BUNDLER_VER}"

# Setting default ruby version
echo -e "$hr\nDEFAULT VERSION\n$hr"
ruby -v && bundle version
node -v && npm -v

# Generate a Gemfile.lock
# $ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app combos/ruby_node:3_16 bundle install
