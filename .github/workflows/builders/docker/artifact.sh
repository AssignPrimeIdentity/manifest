#!/bin/bash

# environtment
echo -e "\n$hr\nENVIRONTMENT\n$hr"
printenv | sort

# makefile
echo -e "\n$hr\nMAKEFILE\n$hr"
cat ${WORKING_DIR}/Makefile

# config file
echo -e "\n$hr\nJEKYLL CONFIG FILE\n$hr"
cat ${JEKYLL_CFG}

# pinned repos
# https://dev.to/thomasaudo/get-started-with-github-grapql-api--1g8b
echo -e "\n$hr\nPINNED  REPOSITORIES\n$hr"
AUTH="Authorization: bearer $JEKYLL_GITHUB_TOKEN"
curl -L -X POST "${GITHUB_GRAPHQL_URL}" -H "$AUTH" \
--data-raw '{"query":"{\n  user(login: \"'${GITHUB_REPOSITORY_OWNER}'\") {\n pinnedItems(first: 6, types: REPOSITORY) {\n nodes {\n ... on Repository {\n name\n }\n }\n }\n }\n}"'

# Directory Setting
# remote_theme: eQ19/parser
# https://jekyllrb.com/docs/configuration/default/
# https://jekyllrb.com/docs/continuous-integration/github-actions/
# https://docs.github.com/en/actions/security-guides/encrypted-secrets

# workspace
echo -e "\n$hr\nWORKING DIRECTORY\n$hr"
echo ${WORKING_DIR}
ls -al ${WORKING_DIR}

cd ${JEKYLL_SRC}
git submodule update --init --recursive

echo /primes
ls -al /primes

echo /primes/numberGenerator
ls -al /primes/numberGenerator

echo /primes/numberGenerator/python/spacetimeengine/src
ls -al /primes/numberGenerator/python/spacetimeengine/src

# git clone ${DEFAULT_REPO} src && cd src && mv data _data
cd /primes/numberGenerator/python/spacetimeengine/src
mv _data ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_data data

cd ${JEKYLL_SRC}/_data/_base
mv _maps ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_maps _maps
mv _feeds ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_feeds _feeds
mv _posts ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_posts _posts

cd /primes/numberGenerator
mv assets ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/assets assets
mv _sass ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_sass _sass
mv _layouts ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_layouts _layouts
mv _plugins ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_plugins _plugins
mv _includes ${JEKYLL_SRC}/ && ln -s ${JEKYLL_SRC}/_includes _includes

# jekyll source
echo -e "\n$hr\nJEKYLL DIRECTORY\n$hr"
cd ${JEKYLL_SRC} && pwd
ls -al .
