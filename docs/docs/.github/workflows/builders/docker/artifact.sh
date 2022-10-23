#!/bin/bash

# identity
echo -e "\n$hr\nWHOAMI\n$hr"
chown -R $(id -u):$(id -g) $PWD
whoami
pwd
id

# os version
echo -e "\n$hr\nOS VERSION\n$hr"
cat /etc/os-release
uname -r

# file system
echo -e "\n$hr\nFILE SYSTEM\n$hr"
df -h

# ls /
echo -e "\n$hr\nALL REPOSITORY\n$hr"
echo "/"
ls -al /

# root
echo -e "\n$hr\nROOT PROFILES\n$hr"
echo "/root"
[[ "$(whoami)" == "root" ]] && ls -alL /root || sudo bash -c 'ls -alL /root'

# root ssh
echo -e "\n$hr\nSSH FILES\n$hr"
echo "/root/.ssh"
[[ "$(whoami)" == "root" ]] && ls -alL /root/.ssh || sudo bash -c 'ls -alL /root/.ssh'

# home
echo -e "\n$hr\nHOME PROFILES\n$hr"
echo $HOME
ls -al $HOME
# echo $HOME/.local/bin

# git config
echo -e "\n$hr\nCONFIG FILE\n$hr"
cat $HOME/.gitconfig

# bundel
echo -e "\n$hr\nBUNDLE PATH\n$hr"
echo ${BUNDLE_PATH}
ls -al ${BUNDLE_PATH}

# pinned repos
# https://dev.to/thomasaudo/get-started-with-github-grapql-api--1g8b
echo -e "\n$hr\nPINNED  REPOSITORIES\n$hr"
AUTH="Authorization: bearer $JEKYLL_GITHUB_TOKEN"
curl -L -X POST "https://api.github.com/graphql" -H "$AUTH" \
--data-raw '{"query":"{\n  user(login: \"'${GITHUB_REPOSITORY_OWNER}'\") {\n pinnedItems(first: 6, types: REPOSITORY) {\n nodes {\n ... on Repository {\n name\n }\n }\n }\n }\n}"'

# workspace
echo -e "\n$hr\nWORKING DIRECTORY\n$hr"
echo ${WORKING_DIR}.
ls -al ${WORKING_DIR}. .

# jekyll source
echo -e "\n$hr\nJEKYLL DIRECTORY\n$hr"
pwd
echo ${WORKING_DIR}/${JEKYLL_SRC}.
ls -al ${WORKING_DIR}/${JEKYLL_SRC}

# asset files
echo -e "\n$hr\nASSET FILES\n$hr"
# https://stackoverflow.com/a/42137273/4058484
ls -al ${WORKING_DIR}/${JEKYLL_SRC}/docs/assets

# environtment
echo -e "\n$hr\nENVIRONTMENT\n$hr"
printenv | sort

# installed packages
echo -e "\n$hr\nINSTALLED PACKAGES\n$hr"
dpkg -l

# makefile
echo -e "\n$hr\nMAKEFILE\n$hr"
cat ${WORKING_DIR}/${JEKYLL_SRC}/Makefile

# config file
echo -e "\n$hr\nJEKYLL CONFIG FILE\n$hr"
cat ${WORKING_DIR}/${JEKYLL_SRC}/${JEKYLL_CFG}

echo -e "\n"
