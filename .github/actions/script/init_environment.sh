#!/bin/bash

# identity
echo -e "\n$hr\nWHOAMI\n$hr"
whoami
pwd
id

# os version
echo -e "\n$hr\nOS VERSION\n$hr"
cat /etc/os-release
uname -r

# Setting default ruby version
echo -e "$hr\nRUBY_NODE VERSION\n$hr"
ruby -v && bundler version
node -v && npm -v

# file system
echo -e "\n$hr\nFILE SYSTEM\n$hr"
df -h

# ls /
echo -e "\n$hr\nROOT DIR\n$hr"
echo "/"
ls -al /

# root
echo -e "\n$hr\nROOT PROFILES\n$hr"
echo "/root"
[[ "$(whoami)" == "root" ]] && ls -alL /root || sudo bash -c 'ls -alL /root'

# root ssh
echo -e "\n$hr\nSSH FILES\n$hr"
echo "/root/.ssh"
mkdir /root/.ssh
[[ "$(whoami)" == "root" ]] && ls -alL /root/.ssh || sudo bash -c 'ls -alL /root/.ssh'

# home
echo -e "\n$hr\nGIT PROFILES\n$hr"
chown -R $(whoami) ${WORKING_DIR}/.git/config
ls -al ${WORKING_DIR}/.git

echo -e "\n$hr\nGIT CPNFIG\n$hr"
git config --unset http.https://github.com/.extraheader
git config --unset-all http.https://github.com/.extraheader
git config --global --unset http.https://github.com/.extraheader
git config --system --unset http.https://github.com/.extraheader
cat ${WORKING_DIR}/.git/config

# installed packages
echo -e "\n$hr\nINSTALLED PACKAGES\n$hr"
dpkg -l

# installed packages
echo -e "\n$hr\nVENDOR BUNDLE\n$hr"
echo ${WORKING_DIR}/vendor
ls -al ${WORKING_DIR}/vendor

# Generate a Gemfile.lock
# $ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app combos/ruby_node:3_16 bundle install
